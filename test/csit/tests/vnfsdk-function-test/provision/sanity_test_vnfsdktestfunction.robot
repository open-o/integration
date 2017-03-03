*** settings ***
Library           Remote    http://127.0.0.1:8271
Library           OperatingSystem
Library           HttpLibrary.HTTP
Library           ArchiveLibrary

*** Variables ***
${vnfsdkfunctest_json}    ${SCRIPTS}/../plans/vnf-sdk-function-test/sanity-check/jsoninput/vnfsdktestfunc.json
${getresult_json}    ${SCRIPTS}/../plans/vnf-sdk-function-test/sanity-check/jsoninput/getresult_failure.json
${request_uri}       http://${MSB_IP}/openoapi/vnfsdk/v1/functest/
${request_body_filepath}    ${SCRIPTS}/../plans/vnf-sdk-function-test/sanity-check/reqinputfiles/RobotScript
${request_body_zipfilepath}    ${SCRIPTS}/../plans/vnf-sdk-function-test/sanity-check/reqzipfiles/RobotScript.zip

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

Create zip file for request
    Create Zip From Files In Directory    ${request_body_filepath}    ${request_body_zipfilepath}

Execute Function test result success
    POST    ${request_uri}
    Set Request Header    Content-Type    multipart/form-data
    Set Request Body    null=${request_body_zipfilepath}
    ${status}=    Get Response Status
    ${body}=    Get Response Body
    Should Not Be Empty    ${body}

