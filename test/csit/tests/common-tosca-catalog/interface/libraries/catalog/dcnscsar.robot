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
uploadCsaPackage
    ${resp}    PostRequestWithFileKeyWords.PostRequestFileUpload    ${LOCAL_URL}    ${LOCAL_CATALOG_PATH}/csars    ${CURDIR}${/}../../resources/DC_NS.csar    DC_NS.csar
    ${dic_id}    simplejson.loads    ${resp.content}
    ${csarId_temp}    get from dictionary    ${dic_id}    csarId
    log    ${csarId_temp}
    ${csar_id}    set variable    ${csarId_temp}
    ${csar_id}    Set Global Variable    ${csar_id}
    Should Be Equal As Strings    ${resp.status_code}    200
    [Return]    ${csarId_temp}