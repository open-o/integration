*** settings ***
Library           Remote    http://127.0.0.1:8271

*** Variables ***
${vnfsdkfunctest_json}    ${SCRIPTS}/../plans/vnf-sdk-function-test/sanity-check/jsoninput/vnfsdktestfunc.json


*** Test Cases ***
Set MSB_IP in json file
    [Documentation]    Write MSB_IP to JSon file
    Set MSB Value    ${MSB_IP}

vnfsdkfunctiontest
    [Documentation]    VNFSDKFunctionTest
    replaceVariablesAndSendREST    ${vnfsdkfunctest_json}    null    null
