*** settings ***
Library           Remote    http://127.0.0.1:8271
Library           OperatingSystem


*** Variables ***
${vnfsdkfunctest_json}    ${SCRIPTS}/../plans/vnf-sdk-marketplace-test/sanity-check/jsoninput/vnfsdktestfunc.json
${getresult_json}    ${SCRIPTS}/../plans/vnf-sdk-marketplace-test/sanity-check/jsoninput/getresult_failure.json


*** Test Cases ***
Set MSB_IP in json file
    [Documentation]    Write MSB_IP to JSon file
    Set MSB Value    ${MSB_IP}

Get Function test result
    [Documentation]    Get Function test result
    replaceVariablesAndSendREST    ${getresult_json}    null    null

Execute Function test result
    [Documentation]    Execute Function test result
    ${status}=    Run    curl -i -X POST -H "Content-Type: multipart/form-data" -F "data=@RobotScript.zip" http://${MSB_IP}/openoapi/vnfsdk/v1/functest/  
