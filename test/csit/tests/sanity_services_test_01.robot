*** settings ***
Library  Collections
Library  requests
*** test cases ***

testDriverPort
    BuiltIn.Log    http://${DRIVERMGR_IP}:${DRIVERMGR_PORT}/openoapi/drivermgr/v1/drivers
    ${result} =  get  http://${DRIVERMGR_IP}:${DRIVERMGR_PORT}/openoapi/drivermgr/v1/drivers
    ${json} =  Set Variable  ${result.json()}
    Should Be Equal  ${result.status_code}  ${200}
    ${ip} =  Get From Dictionary  ${json[0]}  ip
    BuiltIn.Log    ${ip}
    ${driverName} =  Get From Dictionary  ${json[0]}  driverName
    BuiltIn.Log    ${driverName}
    Should Be Equal  ${driverName}  ${DRIVER_NAME}
    ${port} =  Get From Dictionary  ${json[0]}  port
    BuiltIn.Log    ${port}
    Should Be Equal  ${port}  ${DRIVER_PORT}

testAddedToMSB
    BuiltIn.Log    http://${MSB_IP}/openoapi/drivermgr/v1/drivers
    ${result} =  get  http://${MSB_IP}/openoapi/drivermgr/v1/drivers
    ${json} =  Set Variable  ${result.json()}
    BuiltIn.Log    ${json}
    Should Be Equal  ${result.status_code}  ${200}
    ${ip} =  Get From Dictionary  ${json[0]}  ip
    BuiltIn.Log    ${ip}
    ${driverName} =  Get From Dictionary  ${json[0]}  driverName
    BuiltIn.Log    ${driverName}
    Should Be Equal  ${driverName}  ${DRIVER_NAME}
    ${port} =  Get From Dictionary  ${json[0]}  port
    BuiltIn.Log    ${port}
    Should Be Equal  ${port}  ${DRIVER_PORT}