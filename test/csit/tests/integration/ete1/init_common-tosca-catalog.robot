*** Settings ***
Force Tags        csars
Library           json
Library           requests
Library           Collections
Library           RequestsLibrary
Resource          ../../common-tosca-catalog/interface/libraries/common/common.robot
Resource          ../../common-tosca-catalog/interface/libraries/catalog/upload-gsosite2dccsar.robot

*** Test Cases ***
uploadCsaPackage
    uploadCsaPackage

queryCsarById
    [Tags]    queryCsarById
    queryCsarById


