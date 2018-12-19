*** Settings ***
Library        KiCadLibrary    schema=connector-validation.sch    pcb=connector-validation.kicad_pcb

*** Test cases ****
ISA Connectors Should Have Same Pinout
    Matching Modules Should Have Same Pads And Netnames    reference=J_ISA_.+

Connectors should be on grid
    ${all_connectors}=    Find Modules         reference=J_ISA_.+
    Module Pads Should Be On Grid    50 mil    ${all_connectors}

Validate edge cuts
    Edge Cuts Should Be On Grid    50 mil
