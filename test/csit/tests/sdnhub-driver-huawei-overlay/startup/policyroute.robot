*** Settings ***
Library           Remote    http://127.0.0.1:8271
Library           BuiltIn
Library           OperatingSystem

*** Variables ***
${policyroute_create}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/policyroute/createpolicyroute.json
${policyroute_create_invalid_ctrluuid}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/policyroute/createpolicyrouteinvalidctrluuid.json
${policyroute_create_invalid_controller}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/policyroute/createpolicyroutecontrollererror.json
${policyroute_update}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/policyroute/updatepolicyroute.json
${policyroute_update_invalid_ctrluuid}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/policyroute/updatepolicyrouteinvalidctrluuid.json
${policyroute_update_invalid_controller}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/policyroute/updatepolicyrouteinvalidconrollerid.json
${policyroute_query}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/policyroute/querypolicyroute.json
${policyroute_query_invalid_ctrluuid}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/policyroute/querypolicyrouteinvalidctrluuid.json
${policyroute_query_invalid_controller}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/policyroute/querypolicyrouteinvalidcontrollerid.json
${policyroute_delete}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/policyroute/deletepolicyroute.json
${policyroute_delete_invalid_ctrluuid}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/policyroute/deletepolicyrouteinvalidtesttype.json
${policyroute_delete_invalid_controller}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/policyroute/deletepolicyrouteinvalidcontrollerid.json

*** Test Cases ***
PolicyRoute create test
    [Documentation]    PolicyRoute create test
    ${policymap}=    Create Dictionary    OVERLAYIP_IP=${OVERLAYIP_IP}    ESR_CNTRL_HTTP=${ESR_CNTRL_HTTP}
    Set Suite Variable    ${policymap}
    Replace variables and send REST    ${policyroute_create}    ${policymap}    controllerId

PolicyRoute create invalid ctrluuid
    [Documentation]    PolicyRoute create fail test with invalid ctrluuid
    Replace variables and send REST    ${policyroute_create_invalid_ctrluuid}    ${policymap}    status

PolicyRoute create invalid conrolle
    [Documentation]    PolicyRoute create fail test with invalid conroller
    Replace variables and send REST    ${policyroute_create_invalid_controller}    ${policymap}    status

PolicyRoute update test
    [Documentation]    PolicyRoute update test
    Replace variables and send REST    ${policyroute_update}    ${policymap}    controllerId

PolicyRoute update invalid ctrluuid
    [Documentation]    PolicyRoute update fail test with invalid ctrluuid
    Replace variables and send REST    ${policyroute_update_invalid_ctrluuid}    ${policymap}    status

PolicyRoute update invalid controller error
    [Documentation]    PolicyRoute update fail test with controller error
    Replace variables and send REST    ${policyroute_update_invalid_controller}    ${policymap}    status

PolicyRoute query test
    [Documentation]    PolicyRoute query test
    Replace variables and send REST    ${policyroute_query}    ${policymap}    id

PolicyRoute query invalid ctrluuid
    [Documentation]    PolicyRoute query fail test with invalid ctrluuid
    Replace variables and send REST    ${policyroute_query_invalid_ctrluuid}    ${policymap}    status

PolicyRoute query invalid conroller id
    [Documentation]    PolicyRoute query fail test with invalid conrollert id
    Replace variables and send REST    ${policyroute_query_invalid_controller}    ${policymap}    status

PolicyRoute delete test
    [Documentation]    PolicyRoute delete test
    Replace variables and send REST    ${policyroute_delete}    ${policymap}    id

PolicyRoute delete invalid ctrluuid
    [Documentation]    PolicyRoute delete fail test with invalid ctrluuid
    Replace variables and send REST    ${policyroute_delete_invalid_ctrluuid}    ${policymap}    status

PolicyRoute delete invalid conroller id
    [Documentation]    PolicyRoute delete fail test with invalid conrollert id
    Replace variables and send REST    ${policyroute_delete_invalid_controller}    ${policymap}    status
