*** Settings ***
Force Tags        ems
Library           requests
Library           json
Library           Collections
Library           RequestsLibrary
Resource          ../libraries/common/common.robot
Resource          ../libraries/extsys/ems.robot

*** Test Cases ***
addEms
    [Tags]    addEms
    addEms

queryEmsById
    [Tags]    queryEmsById
    queryEmsById

queryEmsInstanceById
    [Tags]    queryEmsInstanceById
    queryEmsInstanceById

updateEms
    [Tags]    updateEms
    updateEms

queryAllEms
    [Tags]    queryAllEms
    queryAllEms

deleteEmsById
    [Tags]    deleteEmsById
    deleteEmsById

*** Keywords ***
