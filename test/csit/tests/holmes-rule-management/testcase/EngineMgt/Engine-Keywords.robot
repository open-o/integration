*** Settings ***
Library           Collections
Library           RequestsLibrary
Resource          ../CommonKeywords/HttpRequest.robot
Resource          EngineAddr.robot

*** Keywords ***
engineMgtSuiteVariable
    ${ENGINERULEDIC}    create dictionary    content=package rule20170001
    set suite variable    ${ENGINERULEDIC}

deleteEngineRule
    [Arguments]    ${packageName}    ${codeFlag}=1
    [Documentation]    ${packageName} :The data type is string .
    ${headers}    create dictionary    Content-Type=application/json
    create session    microservices    ${engineHost}    ${headers}
    ${deleteUrl}    set variable    ${engineUrl}/${packageName}
    ${deleteResponse}    delete request    microservices    ${deleteUrl}
    run keyword if    ${codeFlag}==1    Should be equal as strings    ${deleteResponse.status_code}    200
    run keyword if    ${codeFlag}!=1    Should be equal as strings    ${deleteResponse.status_code}    499
    [Return]    ${deleteResponse}

verifyEngineRule
    [Arguments]    ${checkContent}    ${codeFlag}=1
    ${response}    httpPost    ${engineHost}    ${engineUrl}    ${checkContent}
    run keyword if    ${codeFlag}==1    Should be equal as strings    ${response.status_code}    200
    run keyword if    ${codeFlag}!=1    Should be equal as strings    ${response.status_code}    499
    [Return]    ${response}

deployEngineRule
    [Arguments]    ${jsonParams}    ${codeFlag}=1
    ${response}    httpPut    ${engineHost}    ${engineUrl}    ${jsonParams}
    run keyword if    ${codeFlag}==1    Should be equal as strings    ${response.status_code}    200
    run keyword if    ${codeFlag}!=1    Should be equal as strings    ${response.status_code}    499
    [Return]    ${response}
