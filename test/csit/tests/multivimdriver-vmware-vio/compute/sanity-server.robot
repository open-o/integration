#input variables:
SCRIPTS - path to scripts dir
VIMID - vim instance id
TENANTID - tenant uuid
MSB_IP - ip of micro service bus
IMAGE_URL - image url to download and then upload to VIM

*** settings ***
Resource    ../../common.robot
Library     Collections
Library     RequestsLibrary
Library     OperatingSystem
Library     json
Library     HttpLibrary.HTTP

*** Variables ***
@{return_ok_list}=   200  201  202
@{delete_ok_list}=   200  202  204

${esr_url}    /openoapi/extsys/v1/vims
#${servers_url}    /openoapi/multivim-vio/v1/${VIMID}/${TENANTID}/servers

#json files
${multivim_create_server_json}    ${CREATE_SERVER_JSON}
#global vars
${image1Id} 

*** Test Cases ***

GetVimID
    [Documentation]    get vim id
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}     headers=${headers}
    ${resp}=  Get Request    web_session    ${esr_url}
    ${response_json}    json.loads    ${resp.content}
#    Log To Console        ${response_json}
    ${VIMID}=    Convert To String      ${response_json[0]['vimId']}
    Set Global Variable   ${VIMID}



#CreateServerFuncTest
#    [Documentation]    create server rest test
#    ${json_value}=     json_from_file      ${multivim_create_server_json}
#    ${json_string}=     string_from_json   ${json_value}
#    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
#    Create Session    web_session    http://${MSB_IP}    headers=${headers}
#    Set Request Body    ${json_string}
#    ${resp}=    Post Request    web_session     /openoapi/multivim-vio/v1/${VIMID}/${TENANTID}/servers    ${json_string}
#    ${response_code}=     Convert To String      ${resp.status_code}
#    List Should Contain Value    ${return_ok_list}   ${response_code}
#    ${response_json}    json.loads    ${resp.content}
#    ${server1Id}=    Convert To String      ${response_json['id']}
#    Set Global Variable     ${server1Id}
#    Log To Console        ${server1Id}



GetServerFuncTest
    [Documentation]    get information about a particular server
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json  X-Auth-Token=junk
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    /openoapi/multivim-vio/v1/${VIMID}/${TENANTID}/servers/${server1Id}
    ${response_code}=     Convert To String      ${resp.status_code}
    Log To Console        ${response_code}
    List Should Contain Value    ${return_ok_list}   ${response_code}
    ${response_json}    json.loads    ${resp.content}
#    Log To Console        ${response_json}

#ListServerFuncTest
#    [Documentation]    get a list of servers info rest test
#    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json  X-Auth-Token=junk
#    Create Session    web_session    http://${MSB_IP}    headers=${headers}
#    ${resp}=  Get Request    web_session    /openoapi/multivim-vio/v1/${VIMID}/${TENANTID}/servers
#    Log To Console        ${resp}
#    ${response_code}=     Convert To String      ${resp.status_code}
#    Log To Console        ${response_code}
#    List Should Contain Value    ${return_ok_list}   ${response_code}
#    ${response_json}    json.loads    ${resp.content}
#    Log To Console        ${response_json}

DeleteServerFuncTest
    [Documentation]    delete the specific server info rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Delete Request    web_session    /openoapi/multivim-vio/v1/${VIMID}/${TENANTID}/servers/${server1Id}
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${delete_ok_list}   ${response_code}


