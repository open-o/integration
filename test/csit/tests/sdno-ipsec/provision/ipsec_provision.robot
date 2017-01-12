*** settings ***
Resource    common.robot
Library  OperatingSystem
Library  json
Library  HttpLibrary.HTTP

*** Variables ***
@{return_ok_list}=   200  201
${vims_link}  /openoapi/extsys/v1/vims
${sdnocontrollers_link}  /openoapi/extsys/v1/sdncontrollers/
${ac_controller_file}     huawei_ac_controller.json
${dc_controller_file}     huawei_dc_controller.json
${huawei_dc_contr_1}    huawei_dc_controller_reg_esr_1.json
${huawei_dc_contr_2}    huawei_dc_controller_reg_esr_2.json
${elements_link}        /openoapi/sdnobrs/v1/managed-elements

*** Keywords ***
json_from_file
    [Arguments]    ${file_path}
    ${json_file}=    Get file    ${file_path}
    ${json_object}=    Evaluate    json.loads('''${json_file}''')    json
    [return]    ${json_object}

random_ip
    [Arguments]
    ${numbers}=    Evaluate    random.sample([x for x in range(1, 256)], 4)    random
    ${generated_ip}=    Catenate    ${numbers[0]}.${numbers[1]}.${numbers[2]}.${numbers[3]}
    [return]    ${generated_ip}

string_from_json
    [Arguments]    ${json_value}
    ${json_string}=   Stringify Json     ${json_value}
    BuiltIn.Log     ${json_string}
    [return]    ${json_string}

*** Test Cases ***
Test: Register Huawei AC controller
    [Tags]  ESR
    ${json_value}=     json_from_file      ${ac_controller_file}
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     uri=${sdnocontrollers_link}    data=${json_string}
    ${response_json}    json.loads    ${resp.content}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}
    Dictionary Should Contain Key  ${response_json}   sdnControllerId
    Set Global Variable    ${ac_controllerID}      ${response_json['sdnControllerId']}
    BuiltIn.Log    ${ac_controllerID}


Test: Register Huawei DC controller
    [Tags]  ESR
    ${json_value}=     json_from_file      ${ac_controller_file}
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     uri=${vims_link}    data=${json_string}
    ${response_json}    json.loads    ${resp.content}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}
    Dictionary Should Contain Key  ${response_json}   vimId
    Set Global Variable    ${dc_controllerID}   ${response_json['vimId']}
    BuiltIn.Log    ${dc_controllerID}

Test: add elements to BRS
    [Tags]  Managed elements
    Create Http Context    ${MSB_IP}    http
    ${json_value}=     json_from_file      ${huawei_dc_contr_1}
    Remove From Dictionary  ${json_value['managedElement']}   ipAddress
    ${generated_ip}=    random_ip
    Set To Dictionary  ${json_value['managedElement']}    ipAddress    ${generated_ip}
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     uri=${elements_link}    data=${json_string}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}
    ${response_json}    json.loads    ${resp.content}
    ${generated_id}=    Convert To String      ${response_json['managedElement']['id']}
    BuiltIn.Log    ${generated_id}

    ${json_value}=     json_from_file      ${huawei_dc_contr_2}
    Remove From Dictionary  ${json_value['managedElement']}   ipAddress
    ${generated_ip}=    random_ip
    Set To Dictionary  ${json_value['managedElement']}    ipAddress    ${generated_ip}
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     uri=${elements_link}    data=${json_string}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}
    ${response_json}    json.loads    ${resp.content}
    ${generated_id}=    Convert To String      ${response_json['managedElement']['id']}
    BuiltIn.Log    ${generated_id}