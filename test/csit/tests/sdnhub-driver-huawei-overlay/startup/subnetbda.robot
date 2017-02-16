*** Settings ***
Library           Remote    http://127.0.0.1:8271
Library           BuiltIn
Library           OperatingSystem

*** Variables ***
${subnetbda_query}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/subnetbda/querysubnetbda.json
${subnetbda_query_invalid_ctrluuid}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/subnetbda/querysubnetbdainvalidctrluuid.json
${subnetbda_query_invalid_controller}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/subnetbda/querysubnetbdacontrollererror.json

*** Test Cases ***
SubnetBDA query test
    [Documentation]    SubnetBDA query test
    ${subnetmap}=    Create Dictionary    OVERLAYIP_IP=${OVERLAYIP_IP}    ESR_CNTRL_HTTP=${ESR_CNTRL_HTTP}
    Set Suite Variable    ${subnetmap}
    Replace variables and send REST    ${subnetbda_query}    ${subnetmap}    controllerId

SubnetBDA query invalid input
    [Documentation]    SubnetBDA query fail test with invalid input
    Replace variables and send REST    ${subnetbda_query_invalid_ctrluuid}    ${subnetmap}    status

SubnetBDA query invalid conroller error
    [Documentation]    SubnetBDA query fail test with controller error
    Replace variables and send REST    ${subnetbda_query_invalid_controller}    ${subnetmap}    status
