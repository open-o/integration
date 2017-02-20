*** Settings ***
Library           Remote    http://127.0.0.1:8271
Library           BuiltIn
Library           OperatingSystem

*** Variables ***
${l3vpncreate_create}    ${SCRIPTS}/sdnhub-driver-huawei-l3vpn/jsoninput/l3vpncreate.json
${l3vpncreate_update}    ${SCRIPTS}/sdnhub-driver-huawei-l3vpn/jsoninput/l3vpnupdate.json
${l3vpncreate_get}    ${SCRIPTS}/sdnhub-driver-huawei-l3vpn/jsoninput/l3vpnget.json
${l3vpncreate_getfail}    ${SCRIPTS}/sdnhub-driver-huawei-l3vpn/jsoninput/l3vpngetfail.json
${l3vpncreate_delete}    ${SCRIPTS}/sdnhub-driver-huawei-l3vpn/jsoninput/l3vpndelete.json
${l3vpncreate_deletefail}    ${SCRIPTS}/sdnhub-driver-huawei-l3vpn/jsoninput/l3vpndeletefail.json

*** Test Cases ***
L3vpn create test
    [Documentation]    L3vpn create test
    ${devicemap}=    Create Dictionary    L3VPN_IP=${L3VPN_IP}    ESR_CNTRL_HTTP=${ESR_CNTRL_HTTP}
    Set Suite Variable    ${devicemap}
    Replace variables and send REST    ${l3vpncreate_create}    ${devicemap}    null


L3vpn update test
    [Documentation]    L3vpn update test
    Replace variables and send REST    ${l3vpncreate_update}    ${devicemap}    null

L3vpn query test
    [Documentation]    DEVICE query test
    Replace variables and send REST    ${l3vpncreate_get}    ${devicemap}    null

L3vpn query invalid input
    [Documentation]    L3vpn query fail test
    Replace variables and send REST    ${l3vpncreate_getfail}    ${devicemap}    status

L3vpn delete test
    [Documentation]    L3vpn delete test
    Replace variables and send REST    ${l3vpncreate_delete}    ${devicemap}    null

L3vpn delete invalid input
    [Documentation]    L3vpn delete fail test
    Replace variables and send REST    ${l3vpncreate_deletefail}    ${devicemap}    status
