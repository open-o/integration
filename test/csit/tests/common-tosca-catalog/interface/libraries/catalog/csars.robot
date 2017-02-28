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
    ${resp}    PostRequestWithFileKeyWords.PostRequestFileUpload    ${LOCAL_URL}    ${LOCAL_CATALOG_PATH}/csars    ${CURDIR}${/}../../resources/bm.csar    bm.csar
    ${dic_id}    simplejson.loads    ${resp.content}
    ${csarId_temp}    get from dictionary    ${dic_id}    csarId
    log    ${csarId_temp}
    ${csar_id}    set variable    ${csarId_temp}
    ${csar_id}    Set Global Variable    ${csar_id}
    Should Be Equal As Strings    ${resp.status_code}    200
    [Return]    ${csarId_temp}

queryCsarsListByCondition
    ${name}    SET variable    bm
    ${provider}    SET variable
    ${version}    SET variable
    ${deletionPending}    SET variable
    ${type}    SET variable    NFAR
    ${params}    catenate    SEPARATOR=&
    ${resp}=    Get Request    openo    ${LOCAL_CATALOG_PATH}/csars?${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    log    ${resp}
    content-list-size-greater    ${resp}    1    200

queryCsarById
    log    ${csar_id}
    REST.CreateSession
    ${resp}    REST.GetRequest    ${LOCAL_CATALOG_PATH}/csars/${csar_id}
    log    ${resp}
    content-dic-contain    ${resp}    csarId    ${csar_id}    200
    content-list-size-greater    ${resp}    1    200

updateCsar
    [Documentation]    update csars ${csar_id}
    log    ${csar_id}
    ${operationalState}    SET variable
    ${usageState}    SET variable
    ${onBoardState}    SET variable    onBoarded
    ${processState}    SET variable
    ${deletionPending}    SET variable
    ${body}    catenate    SEPARATOR=&    onBoardState=${onBoardState}
    ${resp}    put request    openo    ${LOCAL_CATALOG_PATH}/csars/${csar_id}?${body}
    log    ${resp}
    status-code    ${resp}    200
    ${resp}    Rest.getRequest    ${LOCAL_CATALOG_PATH}/csars/${csar_id}
    @{detail}    to json    ${resp.content}
    ${detail}    get from dictionary    @{detail}    onBoardState
    Should Be Equal As Strings    ${detail}    ${onBoardState}

deleteCsarById
    [Documentation]    delete csar by id ${csar_id}
    log    ${csar_id}
    ${resp}    Rest.deleteRequest    ${LOCAL_CATALOG_PATH}/csars/${csar_id}
    status-code    ${resp}    204
    delete all sessions
    sleep    5
    ${headers}    Create Dictionary    Content-Type    application/json    Accept    application/json
    Create Session    openoaa    ${LOCAL_URL}    headers=${headers}
    ${resp}    get request    openoaa    ${LOCAL_CATALOG_PATH}/csars/${csar_id}
    status-code    ${resp}    200
    log    ${resp.content}
    content-dic-[]    ${resp}    200

downloadCsarById
    ${headers}    Create Dictionary    Content-Type    application/json    Accept    application/json
    Create Session    openo    ${LOCAL_URL}    headers=${headers}
    log    ${csar_id}
    ${path}    set variable    /Plans/nanoinit.zip
    ${params}    set variable    relativePath=${path}
    ${resp}    Get Request    openo    ${LOCAL_CATALOG_PATH}/csars/${csar_id}/files?${params}
    log    ${resp.content}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${content}    to json    ${resp.content}
    ${downloadUri}    get from dictionary    ${content}    downloadUri
    ${respfile}    requests.get    ${downloadUri}
    Should Be Equal As Strings    ${respfile.status_code}    200
    ${downloadUri}    set global variable    ${downloadUri}

checkdownloadurl
    log    ${downloadUri}
    ${respfile}    requests.get    ${downloadUri}
    Should Be Equal As Strings    ${respfile.status_code}    200
