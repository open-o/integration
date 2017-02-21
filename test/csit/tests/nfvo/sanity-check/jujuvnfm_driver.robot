*** settings ***
Resource    ../../common.robot
Library     Collections
Library     RequestsLibrary
Library     simplejson
Library     OperatingSystem
Library     json
Library     HttpLibrary.HTTP

*** Variables ***
@{return_ok_list}=   200  201  202 204
${vnfmId}             test_vnfm_id
${queryconfig_url}    /openoapi/jujuvnfm/v1/config
${addvnf_url}    /openoapi/jujuvnfm/v1/${vnfmId}/vnfs
${getvnf_url}    /openoapi/jujuvnfm/v1/${vnfmId}/vnfs/${vnfInstanceId}
${delvnf_url}    /openoapi/jujuvnfm/v1/${vnfmId}/vnfs/${vnfInstanceId}/terminate

#json files
${juju_addvnf_json}    ${SCRIPTS}/../plans/nfvo/sanity-check/jsoninput/juju_add_vnf.json

#global variables
${vnfInstanceId}

*** Test Cases ***
jujuConfigTest
    [Documentation]    query config info rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    ${queryconfig_url}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}
	
jujuAddVnfTest
    ${json_value}=     json_from_file      ${juju_addvnf_json}
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     ${addvnf_url}    ${json_string}
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${response_code}
	${response_json}    json.loads    ${resp.content}
    ${vnfInstanceId}=    Convert To String      ${response_json['vnfInstanceId']}

jujuGetVnfTest
    [Documentation]    query vnf info rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    ${getvnf_url}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}	

jujuDelVnfTest
	[Documentation]    query vnf info rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=    Post Request    web_session     ${delvnf_url}
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${response_code}
	
	
	
	
	