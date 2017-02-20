*** Settings ***
Library           Remote    http://127.0.0.1:8271
Library           BuiltIn
Library           OperatingSystem

*** Variables ***
${localsite_create}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/localsite/createlocalsite.json
${localsite_create_invalid_ctrluuid}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/localsite/createlocalsiteinvalidctrluuid.json
${localsite_create_invalid_controller}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/localsite/createlocalsitecontrollererror.json
${localsite_delete}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/localsite/deletelocalsite.json
${localsite_delete_invalid_ctrluuid}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/localsite/deletelocalsiteinvalidctrluuid.json
${localsite_delete_invalid_controller}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/localsite/deletelocalsiteinvalidcontrollerid.json
${localsite_update}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/localsite/updatelocalsite.json
${localsite_update_invalid_ctrluuid}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/localsite/updatelocalsiteinvalidctrluuid.json
${localsite_update_invalid_controller}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/localsite/updatelocalsiteinvalidconrollerid.json
${localsite_query}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/localsite/querylocalsite.json
${localsite_query_invalid_ctrluuid}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/localsite/querylocalsiteinvalidctrluuid.json
${localsite_query_invalid_controller}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/localsite/querylocalsiteinvalidcontrollerid.json

*** Test Cases ***
LOCALSITE create test
    [Documentation]    LOCALSITE create test
    ${localsitemap}=    Create Dictionary    OVERLAYIP_IP=${OVERLAYIP_IP}    ESR_CNTRL_HTTP=${ESR_CNTRL_HTTP}
    Replace variables and send REST    ${localsite_create}    ${localsitemap}    controllerId
    Set Suite Variable    ${localsitemap}

LOCALSITE create invalid ctrluuid
    [Documentation]    LOCALSITE create fail test with invalid ctrluuid
    Replace variables and send REST    ${localsite_create_invalid_ctrluuid}    ${localsitemap}    status

LOCALSITE create invalid conroller id
    [Documentation]    LOCALSITE create fail test with invalid conrollert id
    Replace variables and send REST    ${localsite_create_invalid_controller}    ${localsitemap}    status

LOCALSITE update test
    [Documentation]    LOCALSITE update test
    Replace variables and send REST    ${localsite_update}    ${localsitemap}    neId

LOCALSITE update invalid ctrluuid
    [Documentation]    LOCALSITE update fail test with invalid ctrluuid
    Replace variables and send REST    ${localsite_update_invalid_ctrluuid}    ${localsitemap}    neId

LOCALSITE update invalid conroller id
    [Documentation]    LOCALSITE update fail test with invalid conrollert id
    Replace variables and send REST    ${localsite_update_invalid_controller}    ${localsitemap}    neId

LOCALSITE query test
    [Documentation]    LOCALSITE query test
    ${retcode}=    Replace variables and send REST    ${localsite_query}    ${localsitemap}    status

LOCALSITE query invalid ctrluuid
    [Documentation]    LOCALSITE query fail test with invalid ctrluuid
    Replace variables and send REST    ${localsite_query_invalid_ctrluuid}    ${localsitemap}    status

LOCALSITE query invalid conroller id
    [Documentation]    LOCALSITE query fail test with invalid conrollert id
    Replace variables and send REST    ${localsite_query_invalid_controller}    ${localsitemap}    status

LOCALSITE delete test
    [Documentation]    LOCALSITE delete test
    ${retdcode}=    Replace variables and send REST    ${localsite_delete}    ${localsitemap}    status

LOCALSITE delete invalid ctrluuid
    [Documentation]    LOCALSITE delete fail test with invalid ctrluuid
    Replace variables and send REST    ${localsite_delete_invalid_ctrluuid}    ${localsitemap}    status

LOCALSITE delete invalid conroller id
    [Documentation]    LOCALSITE delete fail test with invalid conrollert id
    Replace variables and send REST    ${localsite_delete_invalid_controller}    ${localsitemap}    status
