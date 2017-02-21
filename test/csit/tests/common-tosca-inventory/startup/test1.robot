*** Settings ***
Library       RequestsLibrary

*** Test Cases ***
Liveness Test
    [Documentation]        Check various endpoints for basic liveness check
    Create Session         inventory              http://${INVENTORY_IP}:8203 
    CheckUrl               inventory              /openoapi/inventory/v1/services

*** Keywords ***
CheckUrl
    [Arguments]                   ${session}  ${path}
    ${resp}=                      Get Request          ${session}  ${path}
    Should Be Equal As Integers   ${resp.status_code}  200

