*** Settings ***
Library        KiCadLibrary    schema=subsheet-support.sch    pcb=subsheet-support.kicad_pcb

*** Test cases ****
Should Find Correct Number Of Components
    ${all_modules}=    Find Modules        value=R
    Length Should Be   ${all_modules}      4
