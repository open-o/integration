*** Settings ***
Library       RequestsLibrary

*** Test Cases ***
Liveness Test
    [Documentation]        Check various endpoints for basic liveness check
    Create Session         wso2bpel              http://${WSO2BPEL_IP}:8101 
    CheckUrl               wso2bpel              /openoapi/wso2bpel/v1/swagger.yaml

*** Keywords ***
CheckUrl
    [Arguments]                   ${session}  ${path}
    ${resp}=                      Get Request          ${session}  ${path}
    Should Be Equal As Integers   ${resp.status_code}  200




