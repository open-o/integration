*** settings ***
Resource    ../../common.robot
Library     Collections
Library     RequestsLibrary
Library     OperatingSystem
Library     json
Library     HttpLibrary.HTTP

*** Variables ***
@{return_ok_list}=   200  202

#URI Path
${gso_lcm_serviceInstance_link}     /openoapi/gso/v1/services
${gso_lcm_common_path_link}     /openoapi/gso/v1/services/
${gso_lcm_segments_link}     /openoapi/gso/v1/services/toposequence/
${path_field_operation}     /operations/

#json files used
${createServiceFile}     ${SCRIPTS}/../plans/gso/sanity-check/jsoninput/lcm_CreateServiceReq.json

# Variables used between dependent tests
${service_id}
${operation_id}

*** Test Cases ***
Test: Create service instances
    ${json_value}=     json_from_file      ${createServiceFile}
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     ${gso_lcm_serviceInstance_link}     ${json_string}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}
    ${response_json}    json.loads    ${resp.content}
    ${service_id}=    Convert To String      ${response_json['service']['serviceId']}
    ${operation_id}=    Convert To String      ${response_json['service']['operationId']}
    Set Global Variable     ${service_id}
    Set Global Variable     ${operation_id}
Test: Query all service instances
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=    Get Request    web_session     ${gso_lcm_serviceInstance_link}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}

Test: Query detail of a service instances
    ${query_detail_link}=    Catenate    SEPARATOR=    ${gso_lcm_common_path_link}${service_id}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=    Get Request    web_session     ${query_detail_link}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}

Test: Query operation result of service instance
    ${query_operation_link}=    Catenate    SEPARATOR=    ${gso_lcm_common_path_link}${service_id}${path_field_operation}${operation_id}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=    Get Request    web_session     ${query_operation_link}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}

Test: Delete service instance
    ${delete_intance_link}=    Catenate    SEPARATOR=    ${gso_lcm_common_path_link}${service_id}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=    Delete Request    web_session     ${delete_intance_link}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}

Test: Query topology sequence service segments
    ${query_sequence_link}=    Catenate    SEPARATOR=    ${gso_lcm_segments_link}${service_id}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=    Get Request    web_session     ${query_sequence_link}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}