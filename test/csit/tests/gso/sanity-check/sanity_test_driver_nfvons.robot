*** settings ***
Resource    ../../common.robot
Library     Collections
Library     RequestsLibrary
Library     OperatingSystem
Library     json
Library     HttpLibrary.HTTP

*** Variables ***
@{return_ok_list}=   200  201  202
${createnfvons_url}    /openoapi/gso/v1/nfvodrivers/ns
${instantiatenfvons_url}    /openoapi/gso/v1/nfvodrivers/{nsInstanceId}/instantiate
${querynfvons_url}    /openoapi/gso/v1/nfvodrivers/jobs/{jobId}
${terminatenfvons_url}    /openoapi/gso/v1/nfvodrivers/ns/terminate
${deletenfvons_url}    /openoapi/gso/v1/nfvodrivers/ns/delete

#json files
${driver_createnfvons_json}    ${SCRIPTS}/../plans/gso/sanity-check/jsoninput/driver_createnfvons.json
${driver_instantiatenfvons_json}    ${SCRIPTS}/../plans/gso/sanity-check/jsoninput/driver_instantiatenfvons.json
${driver_querynfvons_json}    ${SCRIPTS}/../plans/gso/sanity-check/jsoninput/driver_querynfvons.json
${driver_terminatenfvons_json}    ${SCRIPTS}/../plans/gso/sanity-check/jsoninput/driver_terminatenfvons.json
${driver_deletenfvons_json}    ${SCRIPTS}/../plans/gso/sanity-check/jsoninput/driver_deletenfvons.json

#global variables
${nsInstanceId}
${jobId}

*** Test Cases ***'
driverCreateNfvoNsFuncTest
    ${json_value}=     json_from_file      ${driver_createnfvons_json}
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     ${createnfvons_url}    ${json_string}
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${response_code}
	${response_json}    json.loads    ${resp.content}
    ${nsInstantceId}=    Convert To String      ${response_json['nsInstantceId']}

driverInstantiateNfvoNsFuncTest
	${json_value}=     json_from_file      ${driver_instantiatenfvons_json}
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     ${instantiatenfvons_url}    ${json_string}
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${response_code}
	${response_json}    json.loads    ${resp.content}
    ${jobId}=    Convert To String      ${response_json['jobId']}
	
driverQueryNfvoNsProgressFuncTest
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${result}=    Get Request    web_session    ${querynfvons_url}
    BuiltIn.log   ${result}
    Should Be Equal  ${result.status_code}  ${200}

driverTerminateNfvoNsFuncTest
    ${json_value}=     json_from_file      ${driver_terminatenfvons_json}
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     ${terminatenfvons_url}    ${json_string}
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${response_code}
	${response_json}    json.loads    ${resp.content}
    ${jobId}=    Convert To String      ${response_json['jobId']}

driverQueryNfvoNsProgressFuncTest
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${result}=    Get Request    web_session    ${querynfvons_url}
    BuiltIn.log   ${result}
    Should Be Equal  ${result.status_code}  ${200}
	
driverDeleteNfvoNsFuncTest
    ${json_value}=     json_from_file      ${driver_deletenfvons_json}
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     ${deletenfvons_url}    ${json_string}
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${response_code}

