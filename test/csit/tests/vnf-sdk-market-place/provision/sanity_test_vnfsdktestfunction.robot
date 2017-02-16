*** settings ***
Library           Remote    http://127.0.0.1:8271
Library           OperatingSystem


*** Variables ***
${vnfsdktest_json}    ${SCRIPTS}/../plans/vnf-sdk-marketplace/sanity-check/jsoninput/vnfsdktestfunc.json
${getresult_json}    ${SCRIPTS}/../plans/vnf-sdk-marketplace/sanity-check/jsoninput/getresult_failure.json


*** Test Cases ***
Basic Health Check
    [Documentation]    MSB registration and health check
    Set MSB Value    ${MSB_IP}

Query and publish CSAR list 
    [Documentation]    Get the result from other hooks
    replaceVariablesAndSendREST    ${getresult_json}    null    null

Upload CSAR to marketplace repository 
    [Documentation]    Upload the VNF Package
    ${status}=    Run    curl -i -X POST -H "Content-Type: multipart/form-data" -F "data=@RobotScript.zip" http://${MSB_IP}/openoapi/vnfsdk/v1/functest/  
