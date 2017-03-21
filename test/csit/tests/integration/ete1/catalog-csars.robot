*** Settings ***
Force Tags        csars
Library           json
Library           requests
Library           Collections
Library           RequestsLibrary
Resource          ../../common-tosca-catalog/interface/libraries/common/common.robot
Resource          ../../common-tosca-catalog/interface/libraries/catalog/csars.robot

*** Test Cases ***
uploadCsaPackage
    uploadCsaPackage

queryCsarById
    [Tags]    queryCsarById
    queryCsarById

queryCsarsListByCondition
    [Tags]    getCsarsListByCondition
    queryCsarsListByCondition

updateCsar
    [Tags]    updateCsar
    updateCsar

downloadCsarById
    [Tags]    downloadCsarById
    downloadCsarById

checkdownloadurl
    [Tags]    checkdownloadurl
    checkdownloadurl
