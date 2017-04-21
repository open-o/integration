*** Settings ***
Resource          ../../variables/variable.robot
Resource          ../common/common.robot
Resource          ../assert/assert-contain.robot
Library           json
Library           String
Library           OperatingSystem
Library           requests
Library           ../python/PostRequestWithFile/PostRequestWithFileKeyWords.py

*** Variables ***
${csar_id}        ${empty}
${downloadUri}    ${empty}

*** Keywords ***
deleteCsarById
    [Documentation]    delete csar by id ${csar_id}
    log    ${csar_id}
    ${resp}    Rest.deleteRequest    ${LOCAL_CATALOG_PATH}/csars/${csar_id}
    status-code    ${resp}    204