*** Settings ***
Library       RequestsLibrary

*** Test Cases ***
Liveness Test
    [Documentation]        Check various endpoints for basic liveness check
    Create Session         extsys              http://${EXTSTS_IP}:8100 
    CheckUrl               extsys              /openoapi/extsys/v1/common

*** Keywords ***
CheckUrl
    [Arguments]                   ${session}  ${path}
    ${resp}=                      Get Request          ${session}  ${path}
    Should Be Equal As Integers   ${resp.status_code}  200

