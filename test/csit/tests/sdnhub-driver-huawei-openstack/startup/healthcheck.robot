*** Settings ***
Library           Remote    http://127.0.0.1:8271
Library           BuiltIn
Library           OperatingSystem

*** Variables ***
${healthcheck_success}    ${SCRIPTS}/sdnhub-driver-huawei-openstack/jsoninput/healthcheck.json


*** Test Cases ***
VxLAN create test
    [Documentation]    Health check MSB UP
    ${healthcheck}=    Create Dictionary    OPENSTACK_IP=${OPENSTACK_IP}
    Replace variables and send REST    ${healthcheck_success}    ${healthcheck}    MSB


