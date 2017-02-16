*** Settings ***
Library           Remote    http://127.0.0.1:8271
Library           BuiltIn
Library           OperatingSystem

*** Variables ***
${healthcheck_success}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/healthcheck/healthcheck.json


*** Test Cases ***
VxLAN create test
    [Documentation]    Health check MSB UP
    ${healthcheck}=    Create Dictionary    OVERLAYIP_IP=${OVERLAYIP_IP}
    Replace variables and send REST    ${healthcheck_success}    ${healthcheck}    MSB


