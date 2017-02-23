*** Settings ***
Library           Remote    http://127.0.0.1:8271
Library           BuiltIn
Library           OperatingSystem

*** Variables ***
${create_l2vpn_success_json}    ${SCRIPTS}/sdnhub-driver-zte-sptn/json/l2vpn/create_l2vpn_success.json
${delete_l2vpn_success_json}    ${SCRIPTS}/sdnhub-driver-zte-sptn/json/l2vpn/delete_l2vpn_success.json
&{variable_map}    DRIVER_IP=${DRIVER_IP}    DRIVER_PORT=${DRIVER_PORT}    SPTN_CONTROLLER_ID=${SPTN_CONTROLLER_ID}

*** Test Cases ***
Create L2vpn Successful
    ${result}=    Replace variables and send REST    ${create_l2vpn_success_json}    ${variable_map}    status

Delete l2vpn successful
    ${result}=    Replace variables and send REST    ${delete_l2vpn_success_json}    ${variable_map}    status
