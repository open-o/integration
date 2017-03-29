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

${esr_url}    /openoapi/extsys/v1/vims
#${networks_url}    /openoapi/multivim/v1/${VIMID}/${TENANTID}/networks


#json files
#${multivim_create_network_json}    ${SCRIPTS}/../plans/multivim/jsoninput/multivim_create_network.json
${multivim_create_network_json}     ${SCRIPTS}/multivimdriver-vmware-vio/jsoninput/multivim_create_network.json

#global vars
${network1Id}

*** Test Cases ***
TestCaseGetVimID
    [Documentation]    Sanity Test - Get VIM ID
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}     headers=${headers}
    ${resp}=  Get Request    web_session    ${esr_url}
    ${response_json}    json.loads    ${resp.content}
#    Log To Console        ${response_json}
    ${VIMID}=    Convert To String      ${response_json[0]['vimId']}
    Set Global Variable   ${VIMID}
#    Log To Console        ${VIMID}

#CreateNetworkFuncTest
#    [Documentation]    create network rest test
#    ${json_value}=     json_from_file      ${multivim_create_network_json}
#    ${json_string}=     string_from_json   ${json_value}
#    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
#    Create Session    web_session    http://${MSB_IP}    headers=${headers}
#    Set Request Body    ${json_string}
##    ${resp}=    Post Request    web_session     ${networks_url}    ${json_string}
#     ${resp}=    Post Request    web_session     /openoapi/multivim-vio/v1/${VIMID}/${TENANTID}/networks    ${json_string}
#    ${response_code}=     Convert To String      ${resp.status_code}
#    List Should Contain Value    ${return_ok_list}   ${response_code}
#    ${response_json}    json.loads    ${resp.content}
#    ${network1Id}=    Convert To String      ${response_json['id']}
#    Set Global Variable     ${network1Id}

TestCaseListNetworks
    [Documentation]    Sanity Test - List Networks
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
#    ${resp}=  Get Request    web_session    ${networks_url}
    ${resp}=  Get Request    web_session    /openoapi/multivim-vio/v1/${VIMID}/${TENANTID}/networks
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${response_code}
    ${response_json}    json.loads    ${resp.content}

TestCaseGetNetwork
    [Documentation]    Sanity Test - Get Network
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
#    ${resp}=  Get Request    web_session    ${networks_url}/${network1Id}
    ${resp}=  Get Request    web_session    /openoapi/multivim-vio/v1/${VIMID}/${TENANTID}/networks/network-csit-1
    ${response_code}=     Convert To String      ${resp.status_code}
    ${response_json}    json.loads    ${resp.content}
    List Should Contain Value    ${return_ok_list}   ${response_code}
    ${response_json}    json.loads    ${resp.content}

TestCaseDeleteNetwork
    [Documentation]    Sanity test - Delete Network
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
#    ${resp}=  Delete Request    web_session    ${networks_url}/${network1Id}
    ${resp}=  Delete Request    web_session    /openoapi/multivim-vio/v1/${VIMID}/${TENANTID}/networks/network-csit-1
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${delete_ok_list}   ${response_code}

