*** Settings ***
Library           Remote    http://127.0.0.1:8271
Library           BuiltIn
Library           OperatingSystem

*** Variables ***
${device_create}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/device/createdevice.json
${device_create_invalid_input}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/device/createdeviceinvalidinput.json
${device_create_invalid_controller}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/device/createdevicecontrollererror.json
${device_update}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/device/updatedevice.json
${device_update_invalid_input}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/device/updatedeviceinvalidinput.json
${device_update_invalid_controller}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/device/updatedevicecontrollererror.json
${device_query}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/device/querydevice.json
${device_query_invalid_input}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/device/querydeviceinvalidinput.json
${device_query_invalid_controller}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/device/querydevicecontrollererror.json
${device_delete}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/device/deletedevice.json
${device_delete_invalid_input}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/device/deletedeviceinvalidinput.json
${device_delete_invalid_controller}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/device/deletedevicecontrollererror.json

*** Test Cases ***
DEVICE create test
    [Documentation]    DEVICE create test
    ${devicemap}=    Create Dictionary    OVERLAYIP_IP=${OVERLAYIP_IP}    ESR_CNTRL_HTTP=${ESR_CNTRL_HTTP}
    Replace variables and send REST    ${device_create}    ${devicemap}    id
    Set Suite Variable    ${devicemap}

DEVICE create invalid input
    [Documentation]    DEVICE create fail test with invalid input
    Replace variables and send REST    ${device_create_invalid_input}    ${devicemap}    status

DEVICE create invalid conroller error
    [Documentation]    DEVICE createfail test with controller error
    Replace variables and send REST    ${device_create_invalid_controller}    ${devicemap}    status

DEVICE update test
    [Documentation]    DEVICE update test
    Replace variables and send REST    ${device_update}    ${devicemap}    id

DEVICE update invalid input
    [Documentation]    DEVICE update fail test with invalid input
    Replace variables and send REST    ${device_update_invalid_input}    ${devicemap}    status

DEVICE update invalid conroller error
    [Documentation]    DEVICE update fail test with controller error
    Replace variables and send REST    ${device_update_invalid_controller}    ${devicemap}    status

DEVICE query test
    [Documentation]    DEVICE query test
    Replace variables and send REST    ${device_query}    ${devicemap}    id

DEVICE query invalid input
    [Documentation]    DEVICE query fail test with invalid input
    Replace variables and send REST    ${device_query_invalid_input}    ${devicemap}    status

DEVICE queryinvalid conrollererror
    [Documentation]    DEVICE query fail test with controller error
    Replace variables and send REST    ${device_query_invalid_controller}    ${devicemap}    status

DEVICE delete test
    [Documentation]    DEVICE delete test
    Replace variables and send REST    ${device_delete}    ${devicemap}    id

DEVICE delete invalid input
    [Documentation]    DEVICE delete fail test with invalid input
    Replace variables and send REST    ${device_delete_invalid_input}    ${devicemap}    status

DEVICE delete invalid conroller error
    [Documentation]    DEVICE update fail test with controller error
    Replace variables and send REST    ${device_delete_invalid_controller}    ${devicemap}    status
