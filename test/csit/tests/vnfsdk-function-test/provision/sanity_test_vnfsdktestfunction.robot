*** settings ***
Library           Remote    http://127.0.0.1:8271
Library           OperatingSystem

*** Variables ***
${vnfsdkfunctest_json}    ${SCRIPTS}/../plans/vnf-sdk-function-test/sanity-check/jsoninput/vnfsdktestfunc.json
${getresult_json}    ${SCRIPTS}/../plans/vnf-sdk-function-test/sanity-check/jsoninput/getresult_failure.json


*** Test Cases ***
Health Check and MSB registration
    [Documentation]    Write MSB_IP to JSon file
    Set MSB Value    ${MSB_IP}

Execute Function test result
    [Documentation]    Execute Function test result
    ${status}=    Run    curl -i -X POST -H "Content-Type: multipart/form-data" -F "data=@RobotScript.zip" http://${MSB_IP}/openoapi/vnfsdk/v1/functest/  

Get Function test result
    [Documentation]    Get Function test result
    replaceVariablesAndSendREST    ${getresult_json}    null    null


