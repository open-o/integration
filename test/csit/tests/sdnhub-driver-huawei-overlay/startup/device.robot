*** Settings ***
Library           Remote    http://127.0.0.1:8271
Library           Collections

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
    doOperationAndGetValue    ${device_create}    id

DEVICE create invalid input
    [Documentation]    DEVICE create fail test with invalid input
    doOperationAndGetValue    ${device_create_invalid_input}    status

DEVICE create invalid conroller error
    [Documentation]    DEVICE createfail test with controller error
    doOperationAndGetValue    ${device_create_invalid_controller}    status

DEVICE update test
    [Documentation]    DEVICE update test
    doOperationAndGetValue    ${device_update}    id

DEVICE update invalid input
    [Documentation]    DEVICE update fail test with invalid input
    doOperationAndGetValue    ${device_update_invalid_input}    status

DEVICE update invalid conroller error
    [Documentation]    DEVICE update fail test with controller error
    doOperationAndGetValue    ${device_update_invalid_controller}    status

DEVICE query test
    [Documentation]    DEVICE query test
    doOperationAndGetValue    ${device_query}    id

DEVICE query invalid input
    [Documentation]    DEVICE query fail test with invalid input
    doOperationAndGetValue    ${device_query_invalid_input}    status

DEVICE queryinvalid conrollererror
    [Documentation]    DEVICE query fail test with controller error
    doOperationAndGetValue    ${device_query_invalid_controller}    status

DEVICE delete test
    [Documentation]    DEVICE delete test
    doOperationAndGetValue    ${device_delete}    id

DEVICE delete invalid input
    [Documentation]    DEVICE delete fail test with invalid input
    doOperationAndGetValue    ${device_delete_invalid_input}    status

DEVICE delete invalid conroller error
    [Documentation]    DEVICE update fail test with controller error
    doOperationAndGetValue    ${device_delete_invalid_controller}    status
