*** settings ***
Library  Collections
Library  requests
*** test cases ***

testDriverPort
    ${result} =  get  http://${DRIVERMGR_IP}:${DRIVERMGR_PORT}/openoapi/drivermgr/v1/drivers
    ${json} =  Set Variable  ${result.json()}
    Should Be Equal  ${result.status_code}  ${200}
    ${dName} =  Get From Dictionary  ${json[0]}  driverName
    Should Be Equal  ${dName}  ${DRIVER_NAME}
    ${port} =  Get From Dictionary  ${json[0]}  port
    Should Be Equal  ${port}  ${DRIVER_PORT}

testAddedToMSB
    ${result} =  get  http://${MSB_IP}/openoapi/drivermgr/v1/drivers
    ${json} =  Set Variable  ${result.json()}
    Should Be Equal  ${result.status_code}  ${200}
    ${dName} =  Get From Dictionary  ${json[0]}  driverName
    Should Be Equal As Strings    ${dName}  ${DRIVER_NAME}
    ${port} =  Get From Dictionary  ${json[0]}  port
    Should Be Equal  ${port}  ${DRIVER_PORT}