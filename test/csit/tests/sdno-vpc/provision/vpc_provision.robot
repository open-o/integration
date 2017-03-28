*** settings ***
Resource    common.robot
Library     Collections
Library     RequestsLibrary
Library     simplejson
Library     OperatingSystem
Library     json
Library     HttpLibrary.HTTP

*** Variables ***
@{return_ok_list}=   200  201

${osControllerVIM_link}     /openoapi/extsys/v1/vims
${createVPC_link}     /openoapi/sdnovpc/v1/vpcs
${createSubner_link}     /openoapi/sdnovpc/v1/subnets

#json files used
${osControllerVIM_file}     vim.json
${createVPC_file}     createVpc.json
${subnetSettings_file}     createSubnet.json

# Variables used between dependent tests
${generated_id}
${vpc_id}


*** Test Cases ***
Test: Register the moco with the driver manager
    ${json_value}=     json_from_file      ${osControllerVIM_file}
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     ${osControllerVIM_link}    ${json_string}
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${response_code}
    ${response_json}    json.loads    ${resp.content}
    ${generated_id}=    Convert To String      ${response_json['vimId']}
    Set Global Variable     ${generated_id}

Test: Create VPC request sent
    Should Be Equal As Strings  ${PREV TEST STATUS}     PASS    Cannot create VPC request if moco registering failed
    ${json_value}=     json_from_file      ${createVPC_file}
    Remove From Dictionary  ${json_value}   osControllerId
    Set To Dictionary  ${json_value}    osControllerId    ${generated_id}
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json    X-Driver-Parameter=extSysID=${generated_id}
    Create Session    web_session    http://${VPC_IP}:8518    headers=${headers}
    Set Request Body    ${json_string}
    Sleep  25s      # without this static sleep value create VPC fails because the post request is too fast
    ${resp}=    Post Request    web_session     ${createVPC_link}    ${json_string}
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${response_code}  VPC request not created
    ${id}=   Convert To String      ${json_value['id']}
    Set Global Variable     ${vpc_id}   ${id}

Test: Create subnet request sent
    Should Be Equal As Strings  ${PREV TEST STATUS}     PASS    Cannot create subnet if VPC request not created
    ${json_value_subnet}=     json_from_file      ${subnetSettings_file}
    Remove From Dictionary  ${json_value_subnet}   vpcId
    Set To Dictionary  ${json_value_subnet}    vpcId    ${vpc_id}
    ${json_subnet_string}=     string_from_json   ${json_value_subnet}
    ${subnet_headers}    Create Dictionary    Content-Type=application/json    Accept=application/json    X-Driver-Parameter=extSysID=${generated_id}
    Create Session    web_session    http://${VPC_IP}:8518    headers=${subnet_headers}
    Set Request Body    ${json_subnet_string}
    ${resp}=    Post Request    web_session     ${createSubner_link}    ${json_subnet_string}
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${response_code}
