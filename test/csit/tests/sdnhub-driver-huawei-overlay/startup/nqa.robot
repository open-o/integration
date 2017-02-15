*** Settings ***
Library           Remote    http://127.0.0.1:8271
Library           BuiltIn
Library           OperatingSystem

*** Variables ***
${nqa_create}     ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/nqa/createnqa.json
${nqa_create_invalid_testtype}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/nqa/createnqainvalidtesttype.json
${nqa_create_invalid_controller}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/nqa/createnqacontrollererror.json
${nqa_delete}     ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/nqa/deletenqa.json
${nqa_delete_invalid_testtype}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/nqa/deletenqainvalidtesttype.json
${nqa_delete_invalid_controller}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/nqa/deletenqainvalidcontrollerid.json
${nqa_update}     ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/nqa/updatenqa.json
${nqa_update_invalid_dstip}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/nqa/updatenqainvaliddstip.json
${nqa_update_invalid_controller}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/nqa/updatenqainvalidconrollerid.json
${nqa_query}      ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/nqa/querynqa.json
${nqa_query_invalid_testtype}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/nqa/querynqainvalidtesttype.json
${nqa_query_invalid_controller}    ${SCRIPTS}/sdnhub-driver-huawei-overlay/jsoninput/nqa/querynqainvalidcontrollerid.json

*** Test Cases ***
NQA create test
    [Documentation]    NQA create test
    ${nqanmap}=    Create Dictionary    OVERLAYIP_IP=${OVERLAYIP_IP}    ESR_CNTRL_HTTP=${ESR_CNTRL_HTTP}
    Replace variables and send REST    ${nqa_create}    ${nqanmap}    neId
    Set Suite Variable    ${nqanmap}

NQA create invalid testType
    [Documentation]    NQA create fail test with invalid testtype
    Replace variables and send REST    ${nqa_create_invalid_testtype}    ${nqanmap}    status

NQA create invalid conroller id
    [Documentation]    NQA create fail test with invalid conrollert id
    Replace variables and send REST    ${nqa_create_invalid_controller}    ${nqanmap}    status

NQA update test
    [Documentation]    NQA update test
    Replace variables and send REST    ${nqa_update}    ${nqanmap}    neId

NQA update invalid dstIp
    [Documentation]    NQA update fail test with invalid dstIp
    Replace variables and send REST    ${nqa_update_invalid_dstip}    ${nqanmap}    neId

NQA update invalid conroller id
    [Documentation]    NQA update fail test with invalid conrollert id
    Replace variables and send REST    ${nqa_update_invalid_controller}    ${nqanmap}    neId

NQA query test
    [Documentation]    NQA query test
    Replace variables and send REST    ${nqa_query}    ${nqanmap}    neId

NQA query invalid testType
    [Documentation]    NQA query fail test with invalid testtype
    Replace variables and send REST    ${nqa_query_invalid_testtype}    ${nqanmap}    status

NQA query invalid conroller id
    [Documentation]    NQA query fail test with invalid conrollert id
    Replace variables and send REST    ${nqa_query_invalid_controller}    ${nqanmap}    status

NQA delete test
    [Documentation]    NQA delete test
    Replace variables and send REST    ${nqa_delete}    ${nqanmap}    neId

NQA delete invalid testType
    [Documentation]    NQA delete fail test with invalid testtype
    Replace variables and send REST    ${nqa_delete_invalid_testtype}    ${nqanmap}    status

NQA delete invalid conroller id
    [Documentation]    NQA delete fail test with invalid conrollert id
    Replace variables and send REST    ${nqa_delete_invalid_controller}    ${nqanmap}    status
