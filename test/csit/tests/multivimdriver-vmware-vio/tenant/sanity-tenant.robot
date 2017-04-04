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
@{delete_ok_list}=  200 204

${esr_url}    /openoapi/extsys/v1/vims
#json files

#global vars

*** Test Cases ***

GetVimID
    [Documentation]    get vim id
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}     headers=${headers}
    ${resp}=  Get Request    web_session    ${esr_url}
    ${response_json}    json.loads    ${resp.content}
    ${VIMID}=    Convert To String      ${response_json[0]['vimId']}
    Set Global Variable   ${VIMID}

TestCaseListTenants
    [Documentation]    Sanity test - List Tenants
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    /openoapi/multivim-vio/v1/${VIMID}/tenants
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}
    ${response_json}    json.loads    ${resp.content}
