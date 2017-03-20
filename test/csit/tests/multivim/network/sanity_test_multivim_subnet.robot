#input variables:
SCRIPTS - path to scripts dir

*** settings ***
Resource    ../../common.robot
Library     Collections
Library     RequestsLibrary
Library     OperatingSystem
Library     json
Library     HttpLibrary.HTTP

*** Variables ***
@{return_ok_list}=   200  201  202
@{delete_ok_list}=   200  204

${networks_url}    /openoapi/multivim/v1/${VIMID}/${TENANTID}/networks
${subnets_url}    /openoapi/multivim/v1/${VIMID}/${TENANTID}/subnets


#json files
#${multivim_create_network_json}    ${SCRIPTS}/../plans/multivim/jsoninput/multivim_create_network.json
#${multivim_create_subnet_json}    ${SCRIPTS}/../plans/multivim/jsoninput/multivim_create_subnet.json
${multivim_create_network_json}    ${CREATE_NETWORK_JSON}
${multivim_create_subnet_json}    ${CREATE_SUBNET_JSON}


#global vars
${network1Id}
${subnet1Id}

*** Test Cases ***
CreateSubnetFuncTest
    [Documentation]    create subnet rest test
    ${json_value}=     json_from_file      ${multivim_create_network_json}
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     ${networks_url}    ${json_string}
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${response_code}
    ${response_json}    json.loads    ${resp.content}
    ${network1Id}=    Convert To String      ${response_json['id']}
    Set Global Variable     ${network1Id}
    ${json_value_subnet}=     json_from_file      ${multivim_create_subnet_json}
    Remove From Dictionary  ${json_value_subnet}   networkId
    Set To Dictionary  ${json_value_subnet}   networkId   ${network1Id}
    ${json_string_subnet}=     string_from_json   ${json_value_subnet}
    Set Request Body    ${json_string_subnet}
    ${resp_subnet}=    Post Request    web_session     ${subnets_url}    ${json_string_subnet}
    ${response_code}=     Convert To String      ${resp_subnet.status_code}
    List Should Contain Value    ${return_ok_list}   ${response_code}
    ${response_json_subnet}    json.loads    ${resp_subnet.content}
    ${subnet1Id}=    Convert To String      ${response_json_subnet['id']}
    Set Global Variable     ${subnet1Id}

ListSubnetsFuncTest
    [Documentation]    get a list of subnets info rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    ${subnets_url}
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${response_code}
    ${response_json}    json.loads    ${resp.content}

GetSubnetFuncTest
    [Documentation]    get the specific subnet info rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    ${subnets_url}/${subnet1Id}
    ${response_code}=     Convert To String      ${resp.status_code}
    ${response_json}    json.loads    ${resp.content}
    List Should Contain Value    ${return_ok_list}   ${response_code}
    ${response_json}    json.loads    ${resp.content}

DeleteSubnetFuncTest
    [Documentation]    delete the specific subnet info rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Delete Request    web_session    ${subnets_url}/${subnet1Id}
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${delete_ok_list}   ${response_code}

