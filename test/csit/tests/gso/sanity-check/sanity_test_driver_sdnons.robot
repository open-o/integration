*** settings ***
Resource    ../../common.robot
Library     Collections
Library     RequestsLibrary
Library     OperatingSystem
Library     json
Library     HttpLibrary.HTTP

*** Variables ***
@{return_ok_list}=   200  201  202
${createsdnons_url}    /openoapi/gso/v1/sdnodrivers/ns
${instantiatesdnons_url}    /openoapi/gso/v1/sdnodrivers/{nsInstanceId}/instantiate
${querysdnons_url}    /openoapi/gso/v1/sdnodrivers/jobs/{jobId}
${terminatesdnons_url}    /openoapi/gso/v1/sdnodrivers/ns/terminate
${deletesdnons_url}    /openoapi/gso/v1/sdnodrivers/ns/delete

#json files
${driver_createsdnons_json}    ${SCRIPTS}/../plans/gso/sanity-check/jsoninput/driver_createsdnons.json
${driver_instantiatesdnons_json}    ${SCRIPTS}/../plans/gso/sanity-check/jsoninput/driver_instantiatesdnons.json
${driver_querysdnons_json}    ${SCRIPTS}/../plans/gso/sanity-check/jsoninput/driver_querysdnons.json
${driver_terminatesdnons_json}    ${SCRIPTS}/../plans/gso/sanity-check/jsoninput/driver_terminatesdnons.json
${driver_deletesdnons_json}    ${SCRIPTS}/../plans/gso/sanity-check/jsoninput/driver_deletesdnons.json

#global variables
${nsInstanceId}
${jobId}

*** Test Cases ***
driverCreateSdnoNsFuncTest
    ${json_value}=     json_from_file      ${driver_createsdnons_json}
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     ${createsdnons_url}    ${json_string}
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${response_code}
    ${response_json}    json.loads    ${resp.content}
    ${nsInstantceId}=    Convert To String      ${response_json['nsInstantceId']}

driverInstantiateSdnoNsFuncTest
    ${json_value}=     json_from_file      ${driver_instantiatesdnons_json}
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     ${instantiatesdnons_url}    ${json_string}
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${response_code}
    ${response_json}    json.loads    ${resp.content}
    ${jobId}=    Convert To String      ${response_json['jobId']}

driverQuerySdnoNsProgressFuncTest
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${result}=    Get Request    web_session    ${querysdnons_url}
    BuiltIn.log   ${result}
    Should Be Equal  ${result.status_code}  ${200}

driverTerminateSdnoNsFuncTest
    ${json_value}=     json_from_file      ${driver_terminatesdnons_json}
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     ${terminatesdnons_url}    ${json_string}
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${response_code}
    ${response_json}    json.loads    ${resp.content}
    ${jobId}=    Convert To String      ${response_json['jobId']}

driverQuerySdnoNsProgressFuncTest
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${result}=    Get Request    web_session    ${querysdnons_url}
    BuiltIn.log   ${result}
    Should Be Equal  ${result.status_code}  ${200}

driverDeleteSdnoNsFuncTest
    ${json_value}=     json_from_file      ${driver_deletesdnons_json}
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     ${deletesdnons_url}    ${json_string}
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${response_code}

