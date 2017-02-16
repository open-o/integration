*** Settings ***
Library           Remote    http://127.0.0.1:8271
Library           BuiltIn
Library           OperatingSystem

*** Variables ***
${port_query}     ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/port/queryport.json
${port_query_invalid_input}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/port/queryportinvalidinput.json
${port_query_invalid_controller}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/port/queryportcontrollererror.json

*** Test Cases ***
PORT query test
    [Documentation]    PORT query test
    ${portmap}=    Create Dictionary    OVERLAYIP_IP=${OVERLAYIP_IP}    ESR_CNTRL_HTTP=${ESR_CNTRL_HTTP}
    Replace variables and send REST    ${port_query}    ${portmap}    neId
    Set Suite Variable    ${portmap}

PORT query invalid testType
    [Documentation]    PORT query fail test with invalid input
    Replace variables and send REST    ${port_query_invalid_input}    ${portmap}    status

PORT query invalid conroller id
    [Documentation]    PORT query fail test with controller error
    Replace variables and send REST    ${port_query_invalid_controller}    ${portmap}    status
