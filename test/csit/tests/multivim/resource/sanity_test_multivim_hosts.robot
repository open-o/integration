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
@{delete_ok_list}=  200 204
${hosts_url}    /openoapi/multivim/v1/${VIMID}/${TENANTID}/hosts

#${hostname}    kilo-controller-0
${hostname}    ${HOSTNAME}
${host_url}    /openoapi/multivim/v1/${VIMID}/${TENANTID}/hosts/${hostname}


#json files

#global vars
${network1Id}

*** Test Cases ***

ListHostsFuncTest
    [Documentation]    get list of hosts of the VIM
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    ${hosts_url}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}
    ${response_json}    json.loads    ${resp.content}

GetHostFuncTest
    [Documentation]    get the specific host of the VIM
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    ${host_url}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}
    ${response_json}    json.loads    ${resp.content}

