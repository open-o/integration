*** Settings ***
Resource    ../../common.robot
Library     Collections
Library     RequestsLibrary
Library     OperatingSystem
Library     json
Library     HttpLibrary.HTTP

*** Variables ***
${uri}  /openoapi/sdnonslcm/v1/healthcheck

*** test cases ***
CheckReturnCode
    [Documentation]    Checks that the service has been deployed and started
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${result}=    Get Request    web_session     uri=${uri}
    BuiltIn.log   ${result}
    [Documentation]    Verify that return code is 200
    Should Be Equal  ${result.status_code}  ${200}