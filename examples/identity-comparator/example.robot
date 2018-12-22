*** Settings ***
Library        KiCadLibrary    schema=identity-comparator.sch    pcb=identity-comparator.kicad_pcb
Suite Setup    Setup Suite

*** Test cases ****
Reference pins should be correctly connected to data bus
    [Documentation]     The (P0--P7) pins on the 74688 are supposed
    \    ...            to be connected to the main data bus' d0-d7.
    :FOR    ${identity_comparator}    IN    @{identity_comparator_list}
    \    Reference Pins Should Be Connected To Correct Net
    \    ...    ${identity_comparator}    P([0-9]+)    d([0-9]+)

VDD Pins should be connected to VDD
    [Documentation]     Modules with schematic pins named VDD should
    \    ...            be connected to VDD net.
    ${components}=    Find Modules    value=.*
    :FOR    ${component}    IN    @{components}
    \    Reference Pins Should Be Connected To Correct Net
    \    ...    ${component}    VCC    VCC

GND Pins should be connected to GND
    [Documentation]     Modules with schematic pins named GND should
    \    ...            be connected to GND net.
    ${components}=    Find Modules    value=.*
    :FOR    ${component}    IN    @{components}
    \    Reference Pins Should Be Connected To Correct Net
    \    ...    ${component}    GND    GND

*** Keywords ***
Reference Pins Should Be Connected To Correct Net
    [Arguments]        ${ic}    ${pins_regexp}    ${pads_regexp}
    [Documentation]     Ensure that the pads on the given module (matching
    \    ...            ${pads_regexp}) align with the schematics reference 
    \    ...            pins (matchting ${pins_regexp}).
    ${pins}=   Get Component Pins For Module    ${ic}    ${pins_regexp}
    ${pads}=   Get Pad Netnames For Module     ${ic}
    :FOR    ${pin}    IN    @{pins}
    \    ${pin_id}=    Should Match Regexp    ${pins["${pin}"]["name"]}    ${pins_regexp}
    \    ${pad_id}=    Should Match Regexp    ${pads["${pin}"]}            ${pads_regexp}
    \    Should Be Equal    ${pin_id[1]}    ${pad_id[1]}

Setup Suite
    @{identity_comparator_list}=    Find Modules    value=74LS688
    Set Suite Variable  @{identity_comparator_list}