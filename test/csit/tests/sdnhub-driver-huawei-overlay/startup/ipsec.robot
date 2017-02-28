*** Settings ***
Library           Remote    http://127.0.0.1:8271
Library           BuiltIn
Library           OperatingSystem

*** Variables ***
${ipsec_create}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/ipsec/createipsec.json
${ipsec_create_invalid_input}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/ipsec/createipsecinvalidinput.json
${ipsec_delete}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/ipsec/deleteipsec.json
${ipsec_delete_invalid_ctrluuid}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/ipsec/deleteipsecinvalidctrluuid.json
${ipsec_update}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/ipsec/updateipsec.json
${ipsec_update_invalid_ctrluuid}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/ipsec/updateipsecinvalidcrtluuid.json
${ipsec_query}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/ipsec/queryipsec.json
${ipsec_query_invalid_ctrluuid}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/ipsec/queryipsecinvalidctrluuid.json

*** Test Cases ***
IpSec create test
    [Documentation]    IpSec create test
    ${ipsecmap}=    Create Dictionary    OVERLAYIP_IP=${OVERLAYIP_IP}    ESR_CNTRL_HTTP=${ESR_CNTRL_HTTP}
    Set Suite Variable    ${ipsecmap}
    Replace variables and send REST    ${ipsec_create}    ${ipsecmap}    controllerId

IpSec create invalid input
    [Documentation]    IpSec create fail test with invalid input
    Replace variables and send REST    ${ipsec_create_invalid_input}    ${ipsecmap}    status

IpSec update test
    [Documentation]    IpSec update test
    Replace variables and send REST    ${ipsec_update}    ${ipsecmap}    controllerId

IpSec update invalid input
    [Documentation]    IpSec update fail test with invalid ctrluuid
    Replace variables and send REST    ${ipsec_update_invalid_ctrluuid}    ${ipsecmap}    status

IpSec query test
    [Documentation]    IpSec query test
    Replace variables and send REST    ${ipsec_query}    ${ipsecmap}    id

IpSec query invalid input
    [Documentation]    IpSec query fail test with invalid input
    Replace variables and send REST    ${ipsec_query_invalid_ctrluuid}    ${ipsecmap}    status

IpSec delete test
    [Documentation]    IpSec delete test
    Replace variables and send REST    ${ipsec_delete}    ${ipsecmap}    controllerId

IpSec delete invalid input
    [Documentation]    IpSec delete fail test with invalid input
    Replace variables and send REST    ${ipsec_delete_invalid_ctrluuid}    ${ipsecmap}    status
