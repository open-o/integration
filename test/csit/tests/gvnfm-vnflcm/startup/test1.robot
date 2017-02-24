*** Settings ***
Resource    ../../common.robot
Library     Collections
Library     RequestsLibrary
Library     OperatingSystem
Library     json
Library     HttpLibrary.HTTP

*** Variables ***
${queryswagger_url}   /openoapi/vnflcm/v1/swagger.json
${createvnf_url}      /openoapi/vnflcm/v1/vnf_instances
${deletevnf_url}      /openoapi/vnflcm/v1/vnf_instances

#json files
${vnflcm_createvnf_json}    ${SCRIPTS}/../plans/gvnfm-vnflcm/sanity-check/jsoninput/vnflcm_createvnf.json

#global variables
${vnfInstId}

*** Test Cases ***
SwaggerFuncTest
    [Documentation]    query swagger info rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    ${queryswagger_url}
    Should Be Equal As Integers   ${resp.status_code}  200
    ${response_json}    json.loads    ${resp.content}
    ${swagger_version}=    Convert To String      ${response_json['swagger']}
    Should Be Equal    ${swagger_version}    2.0

CreateVnf Test
    [Documentation]    Create vnf function test
    ${json_value}=     json_from_file      ${vnflcm_createvnf_json}
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     ${createvnf_url}    ${json_string}
    Should Be Equal As Integers   ${resp.status_code}  201
    ${response_json}    json.loads    ${resp.content}
    ${vnfInstId}=    Convert To String      ${response_json['vnfInstanceId']}

DeleteVnf Test
    [Documentation]    Delete vnf function test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=    Delete Request    web_session     ${deletevnf_url}/${vnfInstId}
    Should Be Equal As Integers   ${resp.status_code}  204
