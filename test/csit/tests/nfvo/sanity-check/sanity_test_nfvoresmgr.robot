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
${vl_url}    /openoapi/resmgr/v1/vl/
${queryvms_url}    /openoapi/resmgr/v1/vm
${vm_url}    /openoapi/resmgr/v1/vm/
${queryvnfinfos_url}    /openoapi/resmgr/v1/vnfinfo
${vnfinfo_url}    /openoapi/resmgr/v1/vnfinfo/
${queryvnfs_url}    /openoapi/resmgr/v1/vnf
${vnf_url}      /openoapi/resmgr/v1/vnf/
${queryvnfstatus_url}    /openoapi/resmgr/v1/vnfstatus
${vnfstatus_url}    /openoapi/resmgr/v1/vnfstatus/
${querycpumemory_url}    /openoapi/resmgr/v1/limits/1234/cpu?vimId=1234
${querydisk_url}    /openoapi/resmgr/v1/limits/1234/disk?vimId=1234


#json files
${resmgr_createvm_json}    ${SCRIPTS}/../plans/nfvo/sanity-check/jsoninput/resmgr_createvm.json
${resmgr_createvl_json}    ${SCRIPTS}/../plans/nfvo/sanity-check/jsoninput/resmgr_createvl.json
${resmgr_createvnfinfo_json}    ${SCRIPTS}/../plans/nfvo/sanity-check/jsoninput/resmgr_createvnfinfo.json
${resmgr_createvnf_json}    ${SCRIPTS}/../plans/nfvo/sanity-check/jsoninput/resmgr_createvnf.json
${resmgr_createvnfstatus_json}   ${SCRIPTS}/../plans/nfvo/sanity-check/jsoninput/resmgr_createvnfstatus.json


#global variables
${vmId}
${vlId}
${vnfInstanceId}

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
    ${response_json}    json.loads    ${resp.content}
    List Should Contain Value    ${return_ok_list}   ${responese_code}
    ${response_json}    json.loads    ${resp.content}

QueryPortsFuncTest
    [Documentation]    query ports info rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    ${queryports_url}
    ${responese_code}=     Convert To String      ${resp.status_code}
    ${response_json}    json.loads    ${resp.content}
    List Should Contain Value    ${return_ok_list}   ${responese_code}

QueryHostsFuncTest
    [Documentation]    query hosts info rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    ${queryhosts_url}
    ${responese_code}=     Convert To String      ${resp.status_code}
    ${response_json}    json.loads    ${resp.content}
    List Should Contain Value    ${return_ok_list}   ${responese_code}

QueryLocationsFuncTest
    [Documentation]    query locations info rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    ${querylocations_url}
    ${responese_code}=     Convert To String      ${resp.status_code}
    ${response_json}    json.loads    ${resp.content}
    List Should Contain Value    ${return_ok_list}   ${responese_code}

QueryDatacentersFuncTest
    [Documentation]    query datacenters info rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    ${querydatacenters_url}
    ${responese_code}=     Convert To String      ${resp.status_code}
    ${response_json}    json.loads    ${resp.content}
    List Should Contain Value    ${return_ok_list}   ${responese_code}

CreateVlFuncTest
    [Documentation]    create vl rest test
    ${json_value}=     json_from_file      ${resmgr_createvl_json}
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     ${queryvls_url}    ${json_string}
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${response_code}
    ${response_json}    json.loads    ${resp.content}
    ${vlId}=    Convert To String      ${response_json['id']}
    Set Global Variable     ${vlId}

QueryVlsFuncTest
    [Documentation]    query vls info rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    ${queryvls_url}
    ${responese_code}=     Convert To String      ${resp.status_code}
    ${response_json}    json.loads    ${resp.content}
    List Should Contain Value    ${return_ok_list}   ${responese_code}

DeleteVlFuncTest
    [Documentation]    delete vl rest test
    ${delete_vl_link}=    Catenate    SEPARATOR=    ${vl_url}${vlId}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=    Delete Request    web_session     ${delete_vl_link}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}

CreateVmFuncTest
    [Documentation]    create vm rest test
    ${json_value}=     json_from_file      ${resmgr_createvm_json}
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     ${queryvms_url}    ${json_string}
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${response_code}
    ${response_json}    json.loads    ${resp.content}
    ${vmId}=    Convert To String      ${response_json['id']}
    Set Global Variable     ${vmId}

QueryVmsFuncTest
    [Documentation]    query vms info rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    ${queryvms_url}
    ${responese_code}=     Convert To String      ${resp.status_code}
    ${response_json}    json.loads    ${resp.content}
    List Should Contain Value    ${return_ok_list}   ${responese_code}

DeleteVmFuncTest
    [Documentation]    delete vm rest test
    ${delete_vm_link}=    Catenate    SEPARATOR=    ${vm_url}${vmId}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=    Delete Request    web_session     ${delete_vm_link}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}

CreateVnfinfoFuncTest
    [Documentation]    create vnfinfo rest test
    ${json_value}=     json_from_file      ${resmgr_createvnfinfo_json}
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     ${queryvnfinfos_url}    ${json_string}
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${response_code}
    ${response_json}    json.loads    ${resp.content}
    ${vnfInstanceId}=    Convert To String      ${response_json['vnfInstanceId']}
    Set Global Variable     ${vnfInstanceId}

QueryVnfinfosFuncTest
    [Documentation]    query vnfinfo rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    ${queryvnfinfos_url}
    ${responese_code}=     Convert To String      ${resp.status_code}
    ${response_json}    json.loads    ${resp.content}
    List Should Contain Value    ${return_ok_list}   ${responese_code}

DeleteVnfinfoFuncTest
    [Documentation]    delete vnfinfo rest test
    ${delete_vnfinfo_link}=    Catenate    SEPARATOR=    ${vnfinfo_url}${vnfInstanceId}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=    Delete Request    web_session     ${delete_vnfinfo_link}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}

CreateVnfFuncTest
    [Documentation]    create vnf rest test
    ${json_value}=     json_from_file      ${resmgr_createvnf_json}
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     ${queryvnfs_url}    ${json_string}
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${response_code}
    ${response_json}    json.loads    ${resp.content}
    ${vnfId}=    Convert To String      ${response_json['id']}
    Set Global Variable     ${vnfId}

QueryVnfsFuncTest
    [Documentation]    query vnfs rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    ${queryvnfs_url}
    ${responese_code}=     Convert To String      ${resp.status_code}
    ${response_json}    json.loads    ${resp.content}
    List Should Contain Value    ${return_ok_list}   ${responese_code}

DeleteVnfFuncTest
    [Documentation]    delete vnf rest test
    ${delete_vnf_link}=    Catenate    SEPARATOR=    ${vnf_url}${vnfId}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=    Delete Request    web_session     ${delete_vnf_link}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}

CreateVnfstatusFuncTest
    [Documentation]    create vnfstatus rest test
    ${json_value}=     json_from_file      ${resmgr_createvnfstatus_json}
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     ${queryvnfstatus_url}    ${json_string}
    ${response_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${response_code}
    ${response_json}    json.loads    ${resp.content}
    ${vnfInstanceId}=    Convert To String      ${response_json['vnfInstanceId']}
    Set Global Variable     ${vnfInstanceId}

QueryVnfstatusFuncTest
    [Documentation]    query vnfstatus info rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    ${queryvnfstatus_url}
    ${responese_code}=     Convert To String      ${resp.status_code}
    ${response_json}    json.loads    ${resp.content}
    List Should Contain Value    ${return_ok_list}   ${responese_code}

DeleteVnfstatusFuncTest
    [Documentation]    delete vnfstatus rest test
    ${delete_vm_link}=    Catenate    SEPARATOR=    ${vnfstatus_url}${vnfInstanceId}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=    Delete Request    web_session     ${delete_vm_link}
    ${responese_code}=     Convert To String      ${resp.status_code}
    List Should Contain Value    ${return_ok_list}   ${responese_code}

QueryCpuLimitsFuncTest
    [Documentation]    query cpu memory limits info rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    ${querycpumemory_url}
    ${responese_code}=     Convert To String      ${resp.status_code}
    ${response_json}    json.loads    ${resp.content}
    List Should Contain Value    ${return_ok_list}   ${responese_code}

QueryDiskFuncTest
    [Documentation]    query disk limits info rest test
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    ${resp}=  Get Request    web_session    ${querydisk_url}
    ${responese_code}=     Convert To String      ${resp.status_code}
    ${response_json}    json.loads    ${resp.content}
    List Should Contain Value    ${return_ok_list}   ${responese_code}
