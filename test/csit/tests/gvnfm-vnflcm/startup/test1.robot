*** Settings ***
Library       RequestsLibrary

*** Test Cases ***
Liveness Test
    [Documentation]        Check various endpoints for basic liveness check
    Create Session         vnflcm              http://${VNFLCM_IP}:8801
    CheckUrl               vnflcm              /openoapi/vnflcm/v1/swagger.json

*** Keywords ***
CheckUrl
    [Arguments]                   ${session}  ${path}
    ${resp}=                      Get Request          ${session}  ${path}
    Should Be Equal As Integers   ${resp.status_code}  200

