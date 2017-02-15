*** Settings ***
Library           Remote    http://127.0.0.1:8271
Library           BuiltIn
Library           OperatingSystem

*** Variables ***
${staticroute_create}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/staticroute/createstaticroute.json
${staticroute_create_invalid_input}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/staticroute/createstaticrouteinvalidinput.json
${staticroute_create_invalid_controller}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/staticroute/createstaticroutecontrollererror.json
${staticroute_delete}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/staticroute/deletestaticroute.json
${staticroute_delete_invalid_input}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/staticroute/deletestaticrouteinvalidinput.json
${staticroute_delete_invalid_controller}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/staticroute/deletestaticroutecontrollererror.json
${staticroute_update}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/staticroute/updatestaticroute.json
${staticroute_update_invalid_input}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/staticroute/updatestaticrouteinvalidinput.json
${staticroute_update_invalid_controller}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/staticroute/updatestaticroutecontrollererror.json
${staticroute_query}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/staticroute/querystaticroute.json
${staticroute_query_invalid_input}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/staticroute/querystaticrouteinvalidinput.json
${staticroute_query_invalid_controller}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/staticroute/querystaticroutecontrollererror.json

*** Test Cases ***
STATICROUTE create test
    [Documentation]    STATICROUTE create test
    ${staticmap}=    Create Dictionary    OVERLAYIP_IP=${OVERLAYIP_IP}    ESR_CNTRL_HTTP=${ESR_CNTRL_HTTP}
    Replace variables and send REST    ${staticroute_create}    ${staticmap}    controllerId
    Set Suite Variable    ${staticmap}

STATICROUTE create invalid input
    [Documentation]    STATICROUTE create fail test with invalid input
    Replace variables and send REST    ${staticroute_create_invalid_input}    ${staticmap}    status

STATICROUTE create invalid conroller
    [Documentation]    STATICROUTE create fail test with controller error
    Replace variables and send REST    ${staticroute_create_invalid_controller}    ${staticmap}    status

STATICROUTE update test
    [Documentation]    STATICROUTE update test
    Replace variables and send REST    ${staticroute_update}    ${staticmap}    controllerId

STATICROUTE update invalid input
    [Documentation]    STATICROUTE update fail test with invalid input
    Replace variables and send REST    ${staticroute_update_invalid_input}    ${staticmap}    neId

STATICROUTE update invalid conroller
    [Documentation]    STATICROUTE update fail test with controller error
    Replace variables and send REST    ${staticroute_update_invalid_controller}    ${staticmap}    neId

STATICROUTE query test
    [Documentation]    STATICROUTE query test
    Replace variables and send REST    ${staticroute_query}    ${staticmap}    controllerId

STATICROUTE query invalid input
    [Documentation]    STATICROUTE query fail test with invalid input
    Replace variables and send REST    ${staticroute_query_invalid_input}    ${staticmap}    status

STATICROUTE query invalid conroller
    [Documentation]    STATICROUTE query fail test with controller error
    Replace variables and send REST    ${staticroute_query_invalid_controller}    ${staticmap}    status

STATICROUTE delete test
    [Documentation]    STATICROUTE delete test
    Replace variables and send REST    ${staticroute_delete}    ${staticmap}    id

STATICROUTE delete invalid input
    [Documentation]    STATICROUTE delete fail test with invalid input
    Replace variables and send REST    ${staticroute_delete_invalid_input}    ${staticmap}    status

STATICROUTE delete invalid conroller
    [Documentation]    STATICROUTE delete fail test with controller error
    Replace variables and send REST    ${staticroute_delete_invalid_controller}    ${staticmap}    status
