*** Settings ***
Force Tags        sdnc
Library           requests
Library           json
Library           Collections
Library           RequestsLibrary
Resource          ../libraries/common/common.robot
Resource          ../libraries/extsys/sdnc.robot

*** Test Cases ***
addSdnc
    [Tags]    addSdnc
    addSdnc

querySdncById
    [Tags]    querySdncById
    querySdncById

querySdncInstanceById
    [Tags]    querySdncInstanceById
    querySdncInstanceById

updateSdnc
    [Tags]    updateSdnc
    updateSdnc

queryAllSdnc
    [Tags]    queryAllSdnc
    queryAllSdnc

deleteSdncById
    [Tags]    deleteSdncById
    deleteSdncById

*** Keywords ***
