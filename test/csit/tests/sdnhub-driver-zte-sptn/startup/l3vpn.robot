*** Settings ***
Library           Remote    http://127.0.0.1:8271
Library           BuiltIn
Library           OperatingSystem

*** Variables ***
${create_l3vpn_success_json}    ${SCRIPTS}/sdnhub-driver-zte-sptn/json/l3vpn/create_l3vpn_success.json
${delete_l3vpn_success_json}    ${SCRIPTS}/sdnhub-driver-zte-sptn/json/l3vpn/delete_l3vpn_success.json
&{variable_map}    DRIVER_IP=${DRIVER_IP}    DRIVER_PORT=${DRIVER_PORT}    SPTN_CONTROLLER_ID=${ESR_CNTRL_HTTP}

*** Test Cases ***
Create L3vpn Successful
    Log    ${SCRIPTS}
    Log Many    ${variable_map}
    ${result}=    Replace variables and send REST    ${create_l3vpn_success_json}    ${variable_map}    status

Delete l3vpn successful
    ${result}=    Replace variables and send REST    ${delete_l3vpn_success_json}    ${variable_map}    status
