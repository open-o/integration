*** Settings ***
Library       RequestsLibrary

*** Test Cases ***
Liveness Test
    [Documentation]        Check various endpoints for basic liveness check
    Create Session         msb              http://${MSB_IP}
    CheckUrl               msb              /
    CheckUrl               msb              /openoui/microservices/index.html
    CheckUrl               msb              /api/microservices/v1/swagger.yaml

*** Keywords ***
CheckUrl
    [Arguments]                   ${session}  ${path}
    ${resp}=                      Get Request          ${session}  ${path}
    Should Be Equal As Integers   ${resp.status_code}  200

