*** settings ***
Library  Collections
Library  requests
*** test cases ***

Driver added to Driver Manager
    [Documentation]    Verify that the driver is register correctly on driver manager
    ${result} =  get  http://${DRIVERMGR_IP}:${DRIVERMGR_PORT}/openoapi/drivermgr/v1/drivers
    Should Be Equal  ${result.status_code}  ${200}
    ${json_list} =  Set Variable  ${result.json()}
#   Search for the desired elements in the array of json elements
    :FOR    ${ELEMENT}    IN    @{json_list}
    \    Log    ${ELEMENT}
    \    ${dName} =  Get From Dictionary  ${ELEMENT}  driverName
    \    ${port} =  Get From Dictionary  ${ELEMENT}  port
    \    ${equal_name}     Evaluate    "${dName}" == "${DRIVER_NAME}"
    \    ${equal_port}     Evaluate    "${port}" == "${DRIVER_PORT}"
    \    ${element_found}    Evaluate     ${equal_name} and ${equal_port}
    \    Run Keyword If    ${element_found}    Exit For Loop
    \    Log    "element not found yet"
    \    Log    ${dName}
    Should Be True    ${element_found}


Driver retrieved from Driver Manager through MSB
    [Documentation]    Verify that the driver registration is visible through MSB
    ${result} =  get  http://${MSB_IP}/openoapi/drivermgr/v1/drivers
    Should Be Equal  ${result.status_code}  ${200}
    ${json_list} =  Set Variable  ${result.json()}
#   Search for the desired element in the array of json elements
    :FOR    ${ELEMENT}    IN    @{json_list}
    \    Log    ${ELEMENT}
    \    ${dName} =  Get From Dictionary  ${ELEMENT}  driverName
    \    ${port} =  Get From Dictionary  ${ELEMENT}  port
    \    ${equal_name}     Evaluate    "${dName}" == "${DRIVER_NAME}"
    \    ${equal_port}     Evaluate    "${port}" == "${DRIVER_PORT}"
    \    ${element_found}    Evaluate     ${equal_name} and ${equal_port}
    \    Run Keyword If    ${element_found}    Exit For Loop
    \    Log    "element not found yet"
    \    Log    ${dName}
    Should Be True    ${element_found}

