*** settings ***
Resource    ../../common.robot
Library     Collections
Library     RequestsLibrary
Library     simplejson
Library     OperatingSystem
Library     json
Library     HttpLibrary.HTTP

*** Variables ***
@{return_ok_list}=   200  201  202
${queryservice_url}       /openoapi/servicegateway/v1/services/5212b49f-fe70-414f-9519-88bec35b3190
${querysallservice_url}   /openoapi/servicegateway/v1/services
${querydomains_url}       /openoapi/servicegateway/v1/domains
${genparam_url}           /openoapi/servicegateway/v1/createparameters/79244f5a-970b-4c9d-a836-645720c27edd
${createservice_url}      /openoapi/servicegateway/v1/services
${createservice_reqjson}  ${SCRIPTS}/../plans/gso/sanity-check/jsoninput/sg_create_service.json
${service_id}
${operation_id}
*** Test Cases ***
sgQueryServiceFuncTest
    [Documentation]    query single service rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    ${queryservice_url}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}
    ${response_json}    json.loads    ${resp.content}
    ${serviceName}=    Convert To String      ${response_json['serviceName']}
    Should Be Equal    ${serviceName}    test_gso
sgQueryAllServiceFuncTest
    [Documentation]    query all service rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    ${querysallservice_url}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}
    ${response_json}    json.loads    ${resp.content}
    ${serviceName}=    Convert To String      ${response_json[0]['serviceName']}
    Should Be Equal    ${serviceName}    test_gso
sgQueryDomainsFuncTest
    [Documentation]    query domains info rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    ${querydomains_url}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}
    ${response_json}    json.loads    ${resp.content}
    ${domainName}=    Convert To String      ${response_json[0]['name']}
    Should Be Equal    ${domainName}    localhost
sgGenParametersFuncTest
    [Documentation]    generate create parameters rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    ${genparam_url}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}
    ${response_json}    json.loads    ${resp.content}
    ${templateId}=    Convert To String      ${response_json['templateId']}
    Should Be Equal    ${templateId}    79244f5a-970b-4c9d-a836-645720c27edd
sgCreateServiceFunTest
    [Documentation]    create service rest test
    ${json_value}=     json_from_file      ${register_json}
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     ${createservice_url}    ${json_string}
    Log   ${resp}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}
    ${response_json}    json.loads    ${resp.content}
    ${service_id}=    Convert To String      ${response_json['service']['service_Id']}
    ${operation_id}=    Convert To String      ${response_json['service']['operation_Id']}
sgQueryProgressFunctionTest
    [Documentation]    query progress info rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    /openoapi/servicegateway/v1/services/${service_id}/operations/${operation_id}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}
    ${response_json}    json.loads    ${resp.content}
    ${response_operationId}=    Convert To String      ${response_json['operation']['operation_Id']}
    Should Be Equal    ${response_operationId}    ${operation_id}
sgDeleteServiceFunctionTest
    [Documentation]    delete service rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Delete Request    web_session    /openoapi/servicegateway/v1/services/${service_id}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}
    ${response_json}    json.loads    ${resp.content}
    ${response_operationId}=    Convert To String      ${response_json['operation_Id']}
