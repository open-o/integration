*** Settings ***
Library       RequestsLibrary

*** Test Cases ***
Liveness Test
    [Documentation]        Check various endpoints for basic liveness check
    Create Session         modeldesigner         http://${MODELDESIGNER_IP}:8202
    CheckUrl               modeldesigner         /modeldesign
    CheckUrl               modeldesigner         /modeldesign/nodetypes.html
    CheckUrl               modeldesigner         /modeldesign/servicetemplates.yaml

*** Keywords ***
CheckUrl
    [Arguments]                   ${session}   ${path}
    ${resp}=                      Get Request  ${session}  ${path}
    Should Be Equal As Integers   ${resp.status_code}  200

