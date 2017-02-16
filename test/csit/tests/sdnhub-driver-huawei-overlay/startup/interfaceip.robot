*** Settings ***
Library           Remote    http://127.0.0.1:8271
Library           BuiltIn
Library           OperatingSystem

*** Variables ***
${interfaceip_update}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/interfaceip/updateinterfaceip.json
${interfaceip_update_invalid_ctrluuid}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/interfaceip/updateinterfaceipinvalidctrluuid.json
${interfaceip_update_invalid_input}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/interfaceip/updateinterfaceipinvalidinput.json
${interfaceip_query}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/interfaceip/queryinterfaceip.json
${interfaceip_query_invalid_ctrluuid}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/interfaceip/queryinterfaceipinvalidctrluuid.json
${interfaceip_query_invalid_controller}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/interfaceip/queryinterfaceipcontrollererror.json

*** Test Cases ***
InterfaceIP update test
    [Documentation]    InterfaceIP update test
    ${interfacemap}=    Create Dictionary    OVERLAYIP_IP=${OVERLAYIP_IP}    ESR_CNTRL_HTTP=${ESR_CNTRL_HTTP}
    Replace variables and send REST    ${interfaceip_update}    ${interfacemap}    interfaceName
    Set Suite Variable    ${interfacemap}

InterfaceIP update invalid ctrluuid
    [Documentation]    InterfaceIP update fail test with invalid ctrluuid
    Replace variables and send REST    ${interfaceip_update_invalid_ctrluuid}    ${interfacemap}    status

InterfaceIP update invalid input
    [Documentation]    InterfaceIP update fail test with invalid input json
    Replace variables and send REST    ${interfaceip_update_invalid_input}    ${interfacemap}    status

InterfaceIP query test
    [Documentation]    InterfaceIP query test
    Replace variables and send REST    ${interfaceip_query}    ${interfacemap}    controllerId

InterfaceIP query invalid input
    [Documentation]    InterfaceIP query fail test with invalid input
    Replace variables and send REST    ${interfaceip_query_invalid_ctrluuid}    ${interfacemap}    status

InterfaceIP query invalid conroller error
    [Documentation]    InterfaceIP query fail test with controller error
    Replace variables and send REST    ${interfaceip_query_invalid_controller}    ${interfacemap}    status
