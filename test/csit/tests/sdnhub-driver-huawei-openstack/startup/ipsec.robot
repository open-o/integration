*** Settings ***
Library           Remote    http://127.0.0.1:8271
Library           BuiltIn
Library           OperatingSystem

*** Variables ***
${ipsec_create}    ${SCRIPTS}/sdnhub-driver-huawei-openstack/jsoninput/createipsecv2.json
${ipsec_create_invalid_input}    ${SCRIPTS}/sdnhub-driver-huawei-openstack/jsoninput/createipsecv2invalidinput.json
${ipsec_create_invalid_controller}    ${SCRIPTS}/sdnhub-driver-huawei-openstack/jsoninput/createipsecv2controllererror.json
${ipsec_delete}    ${SCRIPTS}/sdnhub-driver-huawei-openstack/jsoninput/deleteipsecv2.json
${ipsec_delete_invalid_ctrluuid}    ${SCRIPTS}/sdnhub-driver-huawei-openstack/jsoninput/deleteipsecinvalidctrluuid.json
${ipsec_delete_invalid_controller}    ${SCRIPTS}/sdnhub-driver-huawei-openstack/jsoninput/deleteipseccontrollererror.json
${ipsec_update}    ${SCRIPTS}/sdnhub-driver-huawei-openstack/jsoninput/updateipsecv2.json
${ipsec_update_invalid_ctrluuid}    ${SCRIPTS}/sdnhub-driver-huawei-openstack/jsoninput/updateipsecinvalidcrtluuid.json
${ipsec_update_invalid_controller}    ${SCRIPTS}/sdnhub-driver-huawei-openstack/jsoninput/updateipseccontrollererror.json

*** Test Cases ***
IpSec create test
    [Documentation]    IpSec ${ESR_VIM_HTTPS} create test
    ${ipsecmap}=    Create Dictionary    OPENSTACK_IP=${OPENSTACK_IP}    ESR_VIM_HTTPS=${ESR_VIM_HTTPS}
    Set Suite Variable    ${ipsecmap}
    Replace variables and send REST    ${ipsec_create}    ${ipsecmap}    controllerId

IpSec create invalid input
    [Documentation]    IpSec create fail test with invalid input
    Replace variables and send REST    ${ipsec_create_invalid_input}    ${ipsecmap}    status

IpSec create invalid conroller error
    [Documentation]    IpSec create fail test with controller error
    Replace variables and send REST    ${ipsec_create_invalid_controller}    ${ipsecmap}    status

IpSec update test
    [Documentation]    IpSec update test
    Replace variables and send REST    ${ipsec_update}    ${ipsecmap}    controllerId

IpSec update invalid input
    [Documentation]    IpSec update fail test with invalid ctrluuid
    Replace variables and send REST    ${ipsec_update_invalid_ctrluuid}    ${ipsecmap}    status

IpSec update invalid conroller error
    [Documentation]    IpSec update fail test with controller error
    Replace variables and send REST    ${ipsec_update_invalid_controller}    ${ipsecmap}    status

IpSec delete test
    [Documentation]    IpSec delete test
    Replace variables and send REST    ${ipsec_delete}    ${ipsecmap}    controllerId

IpSec delete invalid input
    [Documentation]    IpSec delete fail test with invalid input
    Replace variables and send REST    ${ipsec_delete_invalid_ctrluuid}    ${ipsecmap}    status

IpSec delete invalid conroller error
    [Documentation]    IpSec delete fail test with controller error
    Replace variables and send REST    ${ipsec_delete_invalid_controller}    ${ipsecmap}    status
