*** Settings ***
Library           Remote    http://127.0.0.1:8271
Library           BuiltIn
Library           OperatingSystem

*** Variables ***
${vxlan_create}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/vxlan/createvxlan.json
${vxlan_create_invalid_input}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/vxlan/createvxlaninvalidinput.json
${vxlan_create_invalid_controller}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/vxlan/createvxlancontrollererror.json
${vxlan_delete}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/vxlan/deletevxlan.json
${vxlan_delete_invalid_ctrluuid}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/vxlan/deletevxlaninvalidctrluuid.json
${vxlan_delete_invalid_controller}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/vxlan/deletevxlancontrollererror.json
${vxlan_update}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/vxlan/updatevxlan.json
${vxlan_update_invalid_ctrluuid}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/vxlan/updatevxlaninvalidcrtluuid.json
${vxlan_update_invalid_controller}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/vxlan/updatevxlancontrollererror.json
${vxlan_query}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/vxlan/queryvxlan.json
${vxlan_query_invalid_ctrluuid}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/vxlan/queryvxlaninvalidctrluuid.json
${vxlan_query_invalid_controller}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/vxlan/queryvxlancontrollererror.json

*** Test Cases ***
VxLAN create test
    [Documentation]    VxLAN ${ESR_CNTRL_HTTP} create test
    ${vxlanmap}=    Create Dictionary    OVERLAYIP_IP=${OVERLAYIP_IP}    ESR_CNTRL_HTTP=${ESR_CNTRL_HTTP}
    Replace variables and send REST    ${vxlan_create}    ${vxlanmap}    controllerId
    Set Suite Variable    ${vxlanmap}

VxLAN create invalid input
    [Documentation]    VxLAN create fail test with invalid input
    Replace variables and send REST    ${vxlan_create_invalid_input}    ${vxlanmap}    status

VxLAN create invalid conroller error
    [Documentation]    VxLAN create fail test with controller error
    Replace variables and send REST    ${vxlan_create_invalid_controller}    ${vxlanmap}    status

VxLAN update test
    [Documentation]    VxLAN update test
    Replace variables and send REST    ${vxlan_update}    ${vxlanmap}    controllerId

VxLAN update invalid input
    [Documentation]    VxLAN update fail test with invalid ctrluuid
    Replace variables and send REST    ${vxlan_create_invalid_input}    ${vxlanmap}    status

VxLAN update invalid conroller error
    [Documentation]    VxLAN update fail test with controller error
    Replace variables and send REST    ${vxlan_update_invalid_controller}    ${vxlanmap}    status

VxLAN query test
    [Documentation]    VxLAN query test
    Replace variables and send REST    ${vxlan_query}    ${vxlanmap}    controllerId

VxLAN query invalid input
    [Documentation]    VxLAN query fail test with invalid input
    Replace variables and send REST    ${vxlan_query_invalid_ctrluuid}    ${vxlanmap}    status

VxLAN query invalid conroller error
    [Documentation]    VxLAN query fail test with controller error
    Replace variables and send REST    ${vxlan_query_invalid_controller}    ${vxlanmap}    status

VxLAN delete test
    [Documentation]    VxLAN delete test
    Replace variables and send REST    ${vxlan_delete}    ${vxlanmap}    controllerId

VxLAN delete invalid input
    [Documentation]    VxLAN delete fail test with invalid input
    Replace variables and send REST    ${vxlan_delete_invalid_ctrluuid}    ${vxlanmap}    status

VxLAN delete invalid conroller error
    [Documentation]    VxLAN delete fail test with controller error
    Replace variables and send REST    ${vxlan_delete_invalid_controller}    ${vxlanmap}    status
