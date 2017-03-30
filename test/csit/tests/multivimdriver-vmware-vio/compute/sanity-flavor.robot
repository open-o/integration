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
@{delete_ok_list}=   200  202  204

${esr_url}    /openoapi/extsys/v1/vims

#json files
${multivim_create_flavor_json}    ${SCRIPTS}/multivimdriver-vmware-vio/jsoninput/multivim_create_flavor.json
#${multivim_create_flavor_json}    ${CREATE_FLAVOR_JSON}

#global vars
${flavor1Id} 

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

CreateFlavorFuncTest
    [Documentation]    create flavor rest test
    ${json_value}=     json_from_file      ${multivim_create_flavor_json}
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    Log To Console        ${VIMID}
    Log To Console        ${TENANTID}
    ${resp}=    Post Request    web_session     /openoapi/multivim-vio/v1/${VIMID}/${TENANTID}/flavors    ${json_string}
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${response_code}
    ${response_json}    json.loads    ${resp.content}
    ${flavor1Id}=    Convert To String      ${response_json['id']}
    Set Global Variable     ${flavor1Id}

#ListFlavorsFuncTest
#    [Documentation]    get a list of flavors info rest test
#    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
#    Create Session    web_session    http://${MSB_IP}    headers=${headers}
#    ${resp}=  Get Request    web_session    /openoapi/multivim/v1/${VIMID}/${TENANTID}/flavors
#    ${response_code}=     Convert To String      ${resp.status_code}
#    List Should Contain Value    ${return_ok_list}   ${response_code}
#    ${response_json}    json.loads    ${resp.content}

GetFlavorFuncTest
    [Documentation]    get the specific flavor info rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    /openoapi/multivim-vio/v1/${VIMID}/${TENANTID}/flavors/${flavor1Id}
#     ${resp}=  Get Request    web_session    /openoapi/multivim-vio/v1/${VIMID}/${TENANTID}/flavors/aa
    ${response_code}=     Convert To String      ${resp.status_code}
    ${response_json}    json.loads    ${resp.content}
    List Should Contain Value    ${return_ok_list}   ${response_code}
    ${response_json}    json.loads    ${resp.content}

DeleteFlavorFuncTest
    [Documentation]    delete the specific flavor info rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Delete Request    web_session    /openoapi/multivim-vio/v1/${VIMID}/${TENANTID}/flavors/${flavor1Id}
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${delete_ok_list}   ${response_code}

