*** Settings ***
Library           Remote    http://127.0.0.1:8271
Library           BuiltIn
Library           OperatingSystem

*** Variables ***
${vlan_create}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/vlan/createvlan.json
${vlan_create_invalid_ctrluuid}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/vlan/createvlaninvalidctrluuid.json
${vlan_create_invalid_controller}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/vlan/createvlancontrollererror.json
${vlan_update}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/vlan/updatevlan.json
${vlan_update_invalid_ctrluuid}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/vlan/updatevlaninvalidctrluuid.json
${vlan_update_invalid_controller}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/vlan/updatevlaninvalidconrollerid.json
${vlan_query}     ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/vlan/queryvlan.json
${vlan_query_invalid_ctrluuid}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/vlan/queryvlaninvalidctrluuid.json
${vlan_query_invalid_controller}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/vlan/queryvlaninvalidcontrollerid.json

*** Test Cases ***
VLAN create test
    [Documentation]    VLAN create test
    ${vlanmap}=    Create Dictionary    OVERLAYIP_IP=${OVERLAYIP_IP}    ESR_CNTRL_HTTP=${ESR_CNTRL_HTTP}
    Set Suite Variable    ${vlanmap}
    Replace variables and send REST    ${vlan_create}    ${vlanmap}    neId

VLAN create invalid ctrluuid
    [Documentation]    VLAN create fail test with invalid ctrluuid
    Replace variables and send REST    ${vlan_create_invalid_ctrluuid}    ${vlanmap}    status

VLAN create invalid conroller id
    [Documentation]    VLAN create fail test with invalid conrollert id
    Replace variables and send REST    ${vlan_create_invalid_controller}    ${vlanmap}    status

VLAN query test
    [Documentation]    VLAN query test
    Replace variables and send REST    ${vlan_query}    ${vlanmap}    neId

VLAN query invalid ctrluuid
    [Documentation]    VLAN query fail test with invalid ctrluuid
    Replace variables and send REST    ${vlan_query_invalid_ctrluuid}    ${vlanmap}    status

VLAN query invalid conroller id
    [Documentation]    VLAN query fail test with invalid conrollert id
    Replace variables and send REST    ${vlan_query_invalid_controller}    ${vlanmap}    status

VLAN update test
    [Documentation]    VLAN update test
    Replace variables and send REST    ${vlan_update}    ${vlanmap}    neId

VLAN update invalid ctrluuid
    [Documentation]    VLAN update fail test with invalid ctrluuid
    Replace variables and send REST    ${vlan_update_invalid_ctrluuid}    ${vlanmap}    status

VLAN update invalid conroller id
    [Documentation]    VLAN update fail test with invalid conrollert id
    Replace variables and send REST    ${vlan_update_invalid_controller}    ${vlanmap}    status
