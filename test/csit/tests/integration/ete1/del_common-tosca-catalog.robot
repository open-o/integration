*** Settings ***
Force Tags        csars
Library           json
Library           requests
Library           Collections
Library           RequestsLibrary
Resource          ../../common-tosca-catalog/interface/libraries/common/common.robot
Resource          ../../common-tosca-catalog/interface/libraries/catalog/del-gsosite2dccsar.robot

*** Test Cases ***
deleteCsarById
    [Tags]    deleteCsarById
    deleteCsarById
