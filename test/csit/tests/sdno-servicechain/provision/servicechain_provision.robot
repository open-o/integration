*** settings ***
Resource    ../../common.robot
Library     Collections
Library     RequestsLibrary
Library     simplejson
Library     OperatingSystem
Library     json
Library     HttpLibrary.HTTP

*** Variables ***
@{return_ok_list}=   200  201


${drivermgr_link}     /openoapi/drivermgr/v1/drivers
${sdncontrollers_link}     /openoapi/extsys/v1/sdncontrollers
${managed-elements_link}     /openoapi/sdnobrs/v1/managed-elements

#json files used
${sfc-driver_file}     template-sfc-driver.json
${Reg_FwController_file}     Reg_FwController.json
${Reg_TorCE5850Controller_file}     Reg_TorCE5850Controller.json
${Reg_TorCE6850Controller_file}     Reg_TorCE6850Controller.json
${ManagedElement_Firewall_file}     ManagedElement_Firewall.json


# Variables used between dependent tests
${Reg_FwController_controller_id}
${Reg_TorCE5850Controller_controller_id}
${Reg_TorCE6850Controller_controller_id}

*** Test Cases ***
Test: Register the moco with the driver manager
    ${json_value}=     json_from_file      ${sfc-driver_file}
    Remove From Dictionary  ${json_value}   ip
    Set To Dictionary  ${json_value['driverInfo']}    ip    ${SERVICECHAIN_IP}
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     ${drivermgr_link}    ${json_string}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}

Test: Register Firewall Controller
    ${json_value}=     json_from_file      ${Reg_FwController_file}
    Remove From Dictionary  ${json_value}   url
    Set To Dictionary  ${json_value}    url    http://${MSB_IP}:10001/v2.0
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     ${sdncontrollers_link}    ${json_string}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}
    ${response_json}    json.loads    ${resp.content}
    ${Reg_FwController_controller_id}=    Convert To String      ${response_json['sdnControllerId']}

Test: Register TorCE5850 Controller
    ${json_value}=     json_from_file      ${Reg_TorCE5850Controller_file}
    Remove From Dictionary  ${json_value}   url
    Set To Dictionary  ${json_value}    url    http://${MSB_IP}:10002/v2.0
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     ${sdncontrollers_link}    ${json_string}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}
    ${response_json}    json.loads    ${resp.content}
    ${Reg_TorCE5850Controller_controller_id}=    Convert To String      ${response_json['sdnControllerId']}

Test: Register TorCE6850 Controller
    ${json_value}=     json_from_file      ${Reg_TorCE6850Controller_file}
    Remove From Dictionary  ${json_value}   url
    Set To Dictionary  ${json_value}    url    http://${MSB_IP}:10003/v2.0
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     ${sdncontrollers_link}    ${json_string}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}
    ${response_json}    json.loads    ${resp.content}
    ${Reg_TorCE6850Controller_controller_id}=    Convert To String      ${response_json['sdnControllerId']}

Test: ManagedElement Firewall
    ${json_value}=     json_from_file      ${ManagedElement_Firewall_file}
    Remove From Dictionary  ${json_value['managedElement']}   ipAddress
    ${generated_ip}=    random_ip
    Set To Dictionary  ${json_value['managedElement']}    ipAddress    ${generated_ip}
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    BuiltIn.Log    ${json_string}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     ${managed-elements_link}    ${json_string}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}
    ${response_json}    json.loads    ${resp.content}
    ${managed_element_id}=    Convert To String      ${response_json['managedElement']['id']}
