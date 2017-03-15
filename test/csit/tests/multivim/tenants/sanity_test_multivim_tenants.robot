#input variables:
SCRIPTS - path to scripts dir
#vimid - vim instance id

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
${tenants_url}    /openoapi/multivim/v1/${VIMID}/tenants

#json files

#global vars
${network1Id}

*** Test Cases ***

ListTenantsFuncTest
    [Documentation]    get a list of tenants
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    ${tenants_url}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}
    ${response_json}    json.loads    ${resp.content}

