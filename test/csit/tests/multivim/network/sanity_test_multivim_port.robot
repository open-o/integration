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
${ports_url}    /openoapi/multivim/v1/${VIMID}/${TENANTID}/ports


#json files
${multivim_create_network_json}    ${SCRIPTS}/../plans/multivim/jsoninput/multivim_create_network.json
${multivim_create_subnet_json}    ${SCRIPTS}/../plans/multivim/jsoninput/multivim_create_subnet.json
${multivim_create_port_json}    ${SCRIPTS}/../plans/multivim/jsoninput/multivim_create_port.json

#global vars
${network1Id}
${subnet1Id}
${port1Id}

*** Test Cases ***
CreatePortFuncTest
    [Documentation]    create port rest test
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
    ${json_value_port}=     json_from_file      ${multivim_create_port_json}
    Remove From Dictionary  ${json_value_port}   networkId
    Remove From Dictionary  ${json_value_port}   subnetId
    Set To Dictionary  ${json_value_port}   networkId   ${network1Id}
    Set To Dictionary  ${json_value_port}   subnetId   ${subnet1Id}
    ${json_string_port}=     string_from_json   ${json_value_port}
    Set Request Body    ${json_string_port}
    ${resp_port}=    Post Request    web_session     ${ports_url}    ${json_string_port}
    ${response_code}=     Convert To String      ${resp_port.status_code}
    List Should Contain Value    ${return_ok_list}   ${response_code}
    ${response_json_port}    json.loads    ${resp_port.content}
    ${port1Id}=    Convert To String      ${response_json_port['id']}
    Set Global Variable     ${port1Id}

ListPortsFuncTest
    [Documentation]    get a list of ports info rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    ${ports_url}
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${response_code}
    ${response_json}    json.loads    ${resp.content}

GetPortFuncTest
    [Documentation]    get the specific port info rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    ${ports_url}/${port1Id}
    ${response_code}=     Convert To String      ${resp.status_code}
    ${response_json}    json.loads    ${resp.content}
    List Should Contain Value    ${return_ok_list}   ${response_code}
    ${response_json}    json.loads    ${resp.content}

DeletePortFuncTest
    [Documentation]    delete the specific port info rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Delete Request    web_session    ${ports_url}/${port1Id}
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${delete_ok_list}   ${response_code}

