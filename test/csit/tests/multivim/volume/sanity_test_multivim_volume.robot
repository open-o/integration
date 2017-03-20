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

${volumes_url}    /openoapi/multivim/v1/${VIMID}/${TENANTID}/volumes


#json files
#${multivim_create_volume_json}    ${SCRIPTS}/../plans/multivim/jsoninput/multivim_create_volume.json
${multivim_create_volume_json}    ${CREATE_VOLUME_JSON}

#global vars
${volume1Id} 

*** Test Cases ***
CreateVolumeFuncTest
    [Documentation]    create volume rest test
    ${json_value}=     json_from_file      ${multivim_create_volume_json}
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     ${volumes_url}    ${json_string}
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${response_code}
    ${response_json}    json.loads    ${resp.content}
    ${volume1Id}=    Convert To String      ${response_json['id']}
    Set Global Variable     ${volume1Id}

ListVolumesFuncTest
    [Documentation]    get a list of volumes info rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    ${volumes_url}
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${response_code}
    ${response_json}    json.loads    ${resp.content}

GetVolumeFuncTest
    [Documentation]    get the specific volume info rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    ${volumes_url}/${volume1Id}
    ${response_code}=     Convert To String      ${resp.status_code}
    ${response_json}    json.loads    ${resp.content}
    List Should Contain Value    ${return_ok_list}   ${response_code}
    ${response_json}    json.loads    ${resp.content}

DeleteVolumeFuncTest
    [Documentation]    delete the specific volume info rest test. It will fail on real VIM since it does not wait the created volume be available
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Delete Request    web_session    ${volumes_url}/${volume1Id}
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${delete_ok_list}   ${response_code}

