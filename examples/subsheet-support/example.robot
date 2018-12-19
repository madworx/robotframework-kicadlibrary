*** Settings ***
Library        KiCadLibrary    schema=subsheet-support.sch    pcb=subsheet-support.kicad_pcb

*** Test cases ****
Should Find Correct Number Of Components
    ${all_modules}=    Find Modules        value=R    reference=R[0-9]+
    Length Should Be   ${all_modules}      4

Components should be on grid
    ${all_modules}=    Find Modules            value=R
    Module Pads Should Be On Grid    50 mil    ${all_modules}

Validate edge cuts
    Edge Cuts Should Be On Grid    50 mil
