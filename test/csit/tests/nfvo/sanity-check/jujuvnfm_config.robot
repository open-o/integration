*** settings ***
Resource    ../../common.robot
Library     Collections
Library     RequestsLibrary
Library     simplejson
Library     OperatingSystem
Library     json
Library     HttpLibrary.HTTP

*** Variables ***
@{return_ok_list}=   200  201  202
${queryconfig_url}    /openoapi/jujuvnfm/v1/config

*** Test Cases ***
testMocoFuncTest
    [Documentation]    query single service rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${SIMULATOR_IP}:18008    headers=${headers}
    ${resp}=  Get Request    web_session    ${queryconfig_url}
    ${response_json}    json.loads    ${resp}
    ${debugModel}=    Convert To String      ${response_json['debugModel}']}
    Should Be Equal    ${debugModel}    false
