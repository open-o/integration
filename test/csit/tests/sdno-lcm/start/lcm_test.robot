*** settings ***
Library  Collections
Library     RequestsLibrary

*** Variables ***
${uri}  /openoapi/sdnonslcm/v1/healthcheck

*** test cases ***
testLCMstarted
    #   Checks that the service has been deployed and started
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${result}=    Get Request    web_session     uri=${uri}
    BuiltIn.log   ${result}
    Should Be Equal  ${result.status_code}  ${200}