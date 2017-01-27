*** settings ***
Library  Collections
Library     RequestsLibrary

*** Variables ***
${uri}  /openoapi/sdnonslcm/v1/jobs/j1

*** test cases ***
testLCMstarted
    #   Checks that the service has been deployed and started
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${SERVICE_IP}:${SERVICE_PORT}    headers=${headers}
    ${result}=    Get Request    web_session     uri=${uri}
    BuiltIn.log   ${result}
    Should Be Equal  ${result.status_code}  ${200}