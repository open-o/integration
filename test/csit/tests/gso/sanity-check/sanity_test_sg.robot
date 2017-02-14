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
${queryservice_url}    /openoapi/inventory/v1/services/5212b49f-fe70-414f-9519-88bec35b3190
${querydomains_url}    /openoapi/servicegateway/v1/domains
${genparam_url}        /openoapi/servicegateway/v1/createparameters/79244f5a-970b-4c9d-a836-645720c27edd


*** Test Cases ***
testMocoFuncTest
    [Documentation]    query single service rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${SIMULATOR_IP}:18008    headers=${headers}
    ${resp}=  Get Request    web_session    ${queryservice_url}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}
    ${response_json}    json.loads    ${resp.content}
    ${serviceName}=    Convert To String      ${response_json['serviceName']}
    Should Be Equal    ${serviceName}    test_gso
testMocoFuncTest1
    [Documentation]    query single service rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${SIMULATOR_IP}:18009    headers=${headers}
    ${resp}=  Get Request    web_session    ${queryservice_url}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}
    ${response_json}    json.loads    ${resp.content}
    ${serviceName}=    Convert To String      ${response_json['serviceName']}
    Should Be Equal    ${serviceName}    test_gso    
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