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
${queryswagger_url}    /openoapi/resmgr/v1/swagger.json
${querynetworks_url}    /openoapi/resmgr/v1/networks
${queryports_url}    /openoapi/resmgr/v1/ports
${queryhosts_url}    /openoapi/resmgr/v1/hosts
${querylocations_url}    /openoapi/resmgr/v1/locations
${querydatacenters_url}    /openoapi/resmgr/v1/datacenters
${queryvls_url}    /openoapi/resmgr/v1/vl
${queryvms_url}    /openoapi/resmgr/v1/vm
${createvm_url}    /openoapi/resmgr/v1/vm
${queryvnfinfos_url}    /openoapi/resmgr/v1/vnfinfo
${queryvnfs_url}    /openoapi/resmgr/v1/vnf
${queryvnfstatus_url}    /openoapi/resmgr/v1/vnfstatus

#json files
${resmgr_createvm_json}    ${SCRIPTS}/../plans/nfvo/sanity-check/jsoninput/resmgr_createvm.json

#global variables
${vmId}

*** Test Cases ***
SwaggerFuncTest
    [Documentation]    query swagger info rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    ${queryswagger_url}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}
    ${response_json}    json.loads    ${resp.content}
    ${swagger_version}=    Convert To String      ${response_json['swagger']}
    Should Be Equal    ${swagger_version}    2.0

QueryNetworksFuncTest
    [Documentation]    query networks info rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    ${querynetworks_url}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}
    ${response_json}    json.loads    ${resp.content}
    ${networks}=    Convert To String      ${response_json['networks']}
    Should Be Equal    ${networks}    2.0

QueryPortsFuncTest
    [Documentation]    query ports info rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    ${queryports_url}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}

QueryHostsFuncTest
    [Documentation]    query hosts info rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    ${queryhosts_url}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}

QueryLocationsFuncTest
    [Documentation]    query locations info rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    ${querylocations_url}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}

QueryDatacentersFuncTest
    [Documentation]    query locations info rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    ${querydatacenters_url}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}

QueryVlsFuncTest
    [Documentation]    query locations info rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    ${queryvls_url}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}

QueryVmsFuncTest
    [Documentation]    query locations info rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    ${queryvms_url}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}

CreateVmsFuncTest
    ${json_value}=     json_from_file      ${resmgr_createvm_json}
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     ${createvm_url}    ${json_string}
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${response_code}
    ${response_json}    json.loads    ${resp.content}
    ${vmId}=    Convert To String      ${response_json['id']}

QueryVnfinfosFuncTest
    [Documentation]    query locations info rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    ${queryvnfinfos_url}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}

QueryVnfsFuncTest
    [Documentation]    query locations info rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    ${queryvnfs_url}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}

QueryVnfstatusFuncTest
    [Documentation]    query locations info rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    ${queryvnfstatus_url}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}


