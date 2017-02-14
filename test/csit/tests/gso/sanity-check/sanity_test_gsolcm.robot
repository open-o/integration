*** settings ***
Resource    ../../common.robot
Library     Collections
Library     RequestsLibrary
Library     OperatingSystem
Library     json
Library     HttpLibrary.HTTP

*** Variables ***
@{return_ok_list}=   200  202

${gso_lcm_serviceInstance_link}     /openoapi/gso/v1/services
${gso_lcm_segments_link}     /openoapi/gso/v1/services/toposequence/

#json files used
${createServiceFile}     lcm_CreateServiceReq.json
${queryAllServicesFile}     lcm_QueryAllServices.json
${queryServiceByIdFile}     lcm_QueryServiceById.json
${queryOperationByIdFile}     lcm_QueryServiceOperation.json
${deleteServiceFile}     lcm_DeleteService.json


# Variables used between dependent tests

*** Test Cases ***
Test: Query all service instances
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=    Get Request    web_session     ${gso_lcm_serviceInstance_link}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}