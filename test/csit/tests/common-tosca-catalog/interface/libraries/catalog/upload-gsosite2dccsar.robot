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
    ${resp}    PostRequestWithFileKeyWords.PostRequestFileUpload    ${LOCAL_URL}    ${LOCAL_CATALOG_PATH}/csars    ${CURDIR}${/}../../resources/gso_site2dc.csar    gso_site2dc.csar
    ${dic_id}    simplejson.loads    ${resp.content}
    ${csarId_temp}    get from dictionary    ${dic_id}    csarId
    log    ${csarId_temp}
    ${csar_id}    set variable    ${csarId_temp}
    ${csar_id}    Set Global Variable    ${csar_id}
    Should Be Equal As Strings    ${resp.status_code}    200
    [Return]    ${csarId_temp}

queryCsarById
    log    ${csar_id}
    REST.CreateSession
    ${resp}    REST.GetRequest    ${LOCAL_CATALOG_PATH}/csars/${csar_id}
    log    ${resp}
    content-dic-contain    ${resp}    csarId    ${csar_id}    200
    content-list-size-greater    ${resp}    1    200
