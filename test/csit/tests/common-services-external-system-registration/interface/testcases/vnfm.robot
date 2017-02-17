*** Settings ***
Force Tags        vnfm
Library           requests
Library           json
Library           Collections
Library           RequestsLibrary
Resource          ../libraries/common/common.robot
Resource          ../libraries/extsys/vnfm.robot

*** Test Cases ***
addVnfm
    [Tags]    addVnfm
    addVnfm

queryVnfmById
    [Tags]    queryVnfmById
    queryVnfmById

queryVnfmInstanceById
    [Tags]    queryVnfmInstanceById
    queryVnfmInstanceById

updateVnfm
    [Tags]    updateVnfm
    updateVnfm

queryAllVnfm
    [Tags]    queryAllVnfm
    queryAllVnfm

deleteVnfmById
    [Tags]    deleteVnfmById
    deleteVnfmById

*** Keywords ***
