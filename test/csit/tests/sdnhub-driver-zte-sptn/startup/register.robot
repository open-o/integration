*** Settings ***
Library           Remote    http://127.0.0.1:8271
Library           BuiltIn
Library           OperatingSystem

*** Variables ***
${register_json}    ${SCRIPTS}/sdnhub-driver-zte-sptn/json/register_controller.json
&{variable_map}    MSB_IP=${MSB_IP}    SIMULATOR_IP=${SIMULATOR_IP}

*** Test Cases ***
Write MSB_IP to JSON
    [Documentation]    Write MSB_IP to JSON file
    Set MSB Value    ${MSB_IP}
Register To ESR
    Log    ${SIMULATOR_IP}
    ${SPTN_CONTROLLER_ID}=    Replace variables and send REST    ${register_json}    ${variable_map}    sdnControllerId
    Should Not Be Empty    ${SPTN_CONTROLLER_ID}
    Set Global Variable    ${SPTN_CONTROLLER_ID}
