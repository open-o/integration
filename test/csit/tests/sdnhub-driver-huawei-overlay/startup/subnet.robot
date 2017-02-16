*** Settings ***
Library           Remote    http://127.0.0.1:8271
Library           BuiltIn
Library           OperatingSystem

*** Variables ***
${subnet_create}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/subnet/createsubnet.json
${subnet_create_invalid_ctrluuid}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/subnet/createsubnetinvalidesrid.json
${subnet_create_invalid_controller}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/subnet/createsubnetcontrollererror.json
${subnet_delete}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/subnet/deletesubnet.json
${subnet_delete_invalid_ctrluuid}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/subnet/deletesubnetinvalidctrluuid.json
${subnet_delete_invalid_controller}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/subnet/deletesubnetcontrollererror.json
${subnet_update}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/subnet/updatesubnet.json
${subnet_update_invalid_ctrluuid}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/subnet/updatesubnetinvalidcrtluuid.json
${subnet_update_invalid_controller}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/subnet/updatesubnetcontrollererror.json
${subnet_query}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/subnet/querysubnet.json
${subnet_query_invalid_ctrluuid}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/subnet/querysubnetinvalidctrluuid.json
${subnet_query_invalid_controller}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/subnet/querysubnetcontrollererror.json

*** Test Cases ***
SUBNET create test
    [Documentation]    SUBNET create test
    ${subnetmap}=    Create Dictionary    OVERLAYIP_IP=${OVERLAYIP_IP}    ESR_CNTRL_HTTP=${ESR_CNTRL_HTTP}
    Set Suite Variable    ${subnetmap}
    Replace variables and send REST    ${subnet_create}    ${subnetmap}    neId

SUBNET create invalid testType
    [Documentation]    SUBNET create fail test with invalid ctrluuid
    Replace variables and send REST    ${subnet_create_invalid_ctrluuid}    ${subnetmap}    status

SUBNET create invalid conroller id
    [Documentation]    SUBNET create fail test with controller error
    Replace variables and send REST    ${subnet_create_invalid_controller}    ${subnetmap}    status

SUBNET update test
    [Documentation]    SUBNET update test
    Replace variables and send REST    ${subnet_update}    ${subnetmap}    neId

SUBNET update invalid dstIp
    [Documentation]    SUBNET update fail test with invalid ctrluuid
    Replace variables and send REST    ${subnet_update_invalid_ctrluuid}    ${subnetmap}    neId

SUBNET update invalid conroller id
    [Documentation]    SUBNET update fail test with controller error
    Replace variables and send REST    ${subnet_update_invalid_controller}    ${subnetmap}    neId

SUBNET query test
    [Documentation]    SUBNET query test
    Replace variables and send REST    ${subnet_query}    ${subnetmap}    neId

SUBNET query invalid testType
    [Documentation]    SUBNET query fail test with invalid ctrluuid
    Replace variables and send REST    ${subnet_query_invalid_ctrluuid}    ${subnetmap}    status

SUBNET query invalid conroller id
    [Documentation]    SUBNET query fail test with controller error
    Replace variables and send REST    ${subnet_query_invalid_controller}    ${subnetmap}    status

SUBNET delete test
    [Documentation]    SUBNET delete test
    Replace variables and send REST    ${subnet_delete}    ${subnetmap}    neId

SUBNET delete invalid testType
    [Documentation]    SUBNET delete fail test with invalid ctrluuid
    Replace variables and send REST    ${subnet_delete_invalid_ctrluuid}    ${subnetmap}    status

SUBNET delete invalid conroller id
    [Documentation]    SUBNET delete fail test with controller error
    Replace variables and send REST    ${subnet_delete_invalid_controller}    ${subnetmap}    status
