*** settings ***
Library  Collections
Library  requests

*** test cases ***

testSwaggerFromServiceMachine
    BuiltIn.Log    http://${SERVICE_IP}:${SERVICE_PORT}/openoapi/${SERVICE_NAME}/v1/swagger.json
    ${result} =  get  http://${SERVICE_IP}:${SERVICE_PORT}/openoapi/${SERVICE_NAME}/v1/swagger.json
    Should Be Equal  ${result.status_code}  ${200}
    ${json2} =  Set Variable  ${result.json()}
    BuiltIn.Log    ${json2}

testServiceAddedToMSB
    ${result} =  get  http://${MSB_IP}/openoapi/microservices/v1/services/${SERVICE_NAME}/version/v1
    Should Be Equal  ${result.status_code}  ${200}
    ${json3} =  Set Variable  ${result.json()}

testSwaggerFromMSB
    BuiltIn.Log    http://${MSB_IP}/openoapi/${SERVICE_NAME}/v1/swagger.json
    ${result} =  get  http://${MSB_IP}/openoapi/${SERVICE_NAME}/v1/swagger.json
    Should Be Equal  ${result.status_code}  ${200}
    ${json2} =  Set Variable  ${result.json()}
    BuiltIn.Log    ${json2}
