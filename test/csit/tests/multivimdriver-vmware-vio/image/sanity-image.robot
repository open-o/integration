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

#${images_url}    /openoapi/multivim/v1/${VIMID}/${TENANTID}/images
${esr_url}    /openoapi/extsys/v1/vims

#json files
${multivim_create_image_json}    ${SCRIPTS}/multivimdriver-vmware-vio/jsoninput/multivim_create_image.json

#global vars
${image1Id} 

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


TestCaseCreateImage
    [Documentation]    Sanity Test - Create Image
    ${json_value}=     json_from_file      ${multivim_create_image_json}
    Remove From Dictionary  ${json_value}   imagePath
    Set To Dictionary  ${json_value}   imagePath   http://${SIMULATOR_IP}:18009/openoapi/catalog/v1/cirros-0.3.2-i386-so-disk.vmdk
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}     headers=${headers}
    Set Request Body    ${json_string}
#    Log To Console  ${json_string}
#    Log To Console  ${VIMID}
#    Log To Console  ${TENANTID}
    ${resp}=    Post Request    web_session     /openoapi/multivim-vio/v1/${VIMID}/${TENANTID}/images    ${json_string}
#    Log To Console  ${resp}
    ${response_code}=     Convert To String      ${resp.status_code}
#    Log To Console  ${response_code}
    List Should Contain Value    ${return_ok_list}   ${response_code}
    ${response_json}    json.loads    ${resp.content}
#    Log To Console  ${response_json}
#    Log To Console  ${resp.content}
    ${image1Id}=    Convert To String      ${response_json['id']}
    Set Global Variable     ${image1Id}

TestCaseListImages
    [Documentation]    Sanity Test - Get Images List
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
#    ${resp}=  Get Request    web_session    ${images_url}
    ${resp}=  Get Request    web_session    /openoapi/multivim-vio/v1/${VIMID}/${TENANTID}/images
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${response_code}
    ${response_json}    json.loads    ${resp.content}

TestCaseGetImage
    [Documentation]    Sanity Test - Get Image
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json  X-Auth-Token=junk
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
#    Log To Console        ${VIMID}
    ${resp}=  Get Request    web_session    /openoapi/multivim-vio/v1/${VIMID}/${TENANTID}/images/47e85c63-e5d0-42f7-93b8-a8e0f7360edf
#    Log To Console  ${resp}
    ${response_code}=     Convert To String      ${resp.status_code}
#    Log To Console  ${response_code}
    List Should Contain Value    ${return_ok_list}   ${response_code}
    ${response_json}    json.loads    ${resp.content}
#    Log To Console  ${response_json}
#    Log To Console  ${resp.content}

TestCaseDeleteImage
    [Documentation]    Sanity Test - Delete Image
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
#    ${resp}=  Delete Request    web_session    ${images_url}/${image1Id}
    ${resp}=  Delete Request    web_session    /openoapi/multivim-vio/v1/${VIMID}/${TENANTID}/images/47e85c63-e5d0-42f7-93b8-a8e0f7360edf
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${delete_ok_list}   ${response_code}
