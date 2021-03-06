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

${images_url}    /openoapi/multivim/v1/${VIMID}/${TENANTID}/images


#json files
#${multivim_create_image_json}    ${SCRIPTS}/../plans/multivim/jsoninput/multivim_create_image.json
${multivim_create_image_json}    ${CREATE_IMAGE_JSON}

#global vars
${image1Id} 

*** Test Cases ***
CreateImageFuncTest
    [Documentation]    create image rest test
    ${json_value}=     json_from_file      ${multivim_create_image_json}
    Remove From Dictionary  ${json_value}   imagePath
    Set To Dictionary  ${json_value}   imagePath   http://${SIMULATOR_IP}:18009/openoapi/catalog/v1/cirros-0.3.0-x86_64-disk.img
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     ${images_url}    ${json_string}
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${response_code}
    ${response_json}    json.loads    ${resp.content}
    ${image1Id}=    Convert To String      ${response_json['id']}
    Set Global Variable     ${image1Id}

ListImagesFuncTest
    [Documentation]    get a list of images info rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    ${images_url}
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${response_code}
    ${response_json}    json.loads    ${resp.content}

GetImageFuncTest
    [Documentation]    get the specific image info rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    ${images_url}/${image1Id}
    ${response_code}=     Convert To String      ${resp.status_code}
    ${response_json}    json.loads    ${resp.content}
    List Should Contain Value    ${return_ok_list}   ${response_code}
    ${response_json}    json.loads    ${resp.content}

DeleteImageFuncTest
    [Documentation]    delete the specific image info rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Delete Request    web_session    ${images_url}/${image1Id}
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${delete_ok_list}   ${response_code}

