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

#${volumes_url}    /openoapi/multivim/v1/${VIMID}/${TENANTID}/volumes
${esr_url}      /openoapi/extsys/v1/vims

#json files
#${multivim_create_volume_json}    ${SCRIPTS}/../plans/multivim/jsoninput/multivim_create_volume.json
#${multivim_create_volume_json}    ${CREATE_VOLUME_JSON}
${multivim_create_volume_json}    ${SCRIPTS}/multivimdriver-vmware-vio/jsoninput/multivim_create_volume.json

#global vars
${volume1Id}

*** Test Cases ***
TestCaseGetVimID
    [Documentation]    Sanity Test - Get VIM ID
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}     headers=${headers}
    ${resp}=  Get Request    web_session    ${esr_url}
    ${response_json}    json.loads    ${resp.content}
    ${VIMID}=    Convert To String      ${response_json[0]['vimId']}
    Set Global Variable   ${VIMID}

TestCaseCreateVolume
    [Documentation]    Sanity Test - Create Volume
    ${json_value}=     json_from_file      ${multivim_create_volume_json}
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
#    ${resp}=    Post Request    web_session     ${volumes_url}    ${json_string}
    ${resp}=    Post Request    web_session     /openoapi/multivim-vio/v1/${VIMID}/${TENANTID}/volumes    ${json_string}
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${response_code}
    ${response_json}    json.loads    ${resp.content}
    ${volume1Id}=    Convert To String      ${response_json['id']}
    Set Global Variable     ${volume1Id}

TestCaseListVolumes
    [Documentation]    Sanity Test - List Volume
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    /openoapi/multivim-vio/v1/${VIMID}/${TENANTID}/volumes  params=name=volume-csit-1
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${response_code}
    ${response_json}    json.loads    ${resp.content}

TestCaseGetVolume
    [Documentation]    Sanity Test - Get Volume
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
#    ${resp}=  Get Request    web_session    ${volumes_url}/${volume1Id}
    ${resp}=  Get Request    web_session    /openoapi/multivim-vio/v1/${VIMID}/${TENANTID}/volumes/${volume1Id}
    ${response_code}=     Convert To String      ${resp.status_code}
    ${response_json}    json.loads    ${resp.content}
    List Should Contain Value    ${return_ok_list}   ${response_code}
    ${response_json}    json.loads    ${resp.content}

TestCaseDeleteVolume
    [Documentation]    Sanity Test - Delete Volume
#   [Documentation]    delete the specific volume info rest test. It will fail on real VIM since it does not wait the created volume be available
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
#    ${resp}=  Delete Request    web_session    ${volumes_url}/${volume1Id}
    ${resp}=  Delete Request    web_session    /openoapi/multivim-vio/v1/${VIMID}/${TENANTID}/volumes/${volume1Id}
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${delete_ok_list}   ${response_code}
