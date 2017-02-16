*** settings ***
Resource    ../../common.robot
Library     Collections
Library     RequestsLibrary
Library     OperatingSystem
Library     json
Library     HttpLibrary.HTTP

*** Variables ***
@{return_ok_list}=   200  201  202
${creategsons_url}    /openoapi/gso/v1/gsodrivers/ns/create
${querygsons_url}    /openoapi/gso/v1/gsodrivers/jobs/{jobId}
${deletegsons_url}    /openoapi/gso/v1/gsodrivers/ns/delete

#json files
${driver_creategsons_json}    ${SCRIPTS}/../plans/gso/sanity-check/jsoninput/driver_creategsons.json
${driver_querygsons_json}    ${SCRIPTS}/../plans/gso/sanity-check/jsoninput/driver_querygsons.json
${driver_deletegsons_json}    ${SCRIPTS}/../plans/gso/sanity-check/jsoninput/driver_deletegsons.json

#global variables
${jobId}

*** Test Cases ***
driverCreateGsoNsFuncTest
    ${json_value}=     json_from_file      ${driver_creategsons_json}
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     ${creategsons_url}    ${json_string}
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${response_code}
    ${response_json}    json.loads    ${resp.content}
    ${jobId}=    Convert To String      ${response_json['operationId']}

driverQueryGsoNsProgressFuncTest
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${result}=    Get Request    web_session    ${querygsons_url}
    BuiltIn.log   ${result}
    Should Be Equal  ${result.status_code}  ${200}

driverDeleteGsoNsFuncTest
    ${json_value}=     json_from_file      ${driver_deletegsons_json}
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     ${deletegsons_url}    ${json_string}
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${response_code}
    ${response_json}    json.loads    ${resp.content}
    ${jobId}=    Convert To String      ${response_json['operationId']}

driverQueryGsoNsProgressFuncTest
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${result}=    Get Request    web_session    ${querygsons_url}
    BuiltIn.log   ${result}
    Should Be Equal  ${result.status_code}  ${200}

