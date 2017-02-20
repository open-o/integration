*** Settings ***
Library           Remote    http://127.0.0.1:8271
Library           BuiltIn
Library           OperatingSystem

*** Variables ***
${healthcheck_success}    ${SCRIPTS}/sdnhub-driver-huawei-l3vpn/jsoninput/healthcheck/healthcheck.json


*** Test Cases ***
Health check for driver test
    [Documentation]    Health check MSB UP
    ${healthcheck}=    Create Dictionary    L3VPN_IP=${L3VPN_IP}
    Replace variables and send REST    ${healthcheck_success}    ${healthcheck}    MSB


