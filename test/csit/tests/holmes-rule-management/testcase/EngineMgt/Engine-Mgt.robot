*** Settings ***
Suite Setup       engineMgtSuiteVariable
Suite Teardown    Delete All Sessions
Test Teardown
Test Timeout      1 minute
Library           demjson
Resource          Engine-Keywords.robot

*** Test Cases ***
verify_invalid_rule
    [Documentation]    Verify a rule with invalid contents.
    ${ENGINERULEDIC.content}    set variable    hahahahahahaha
    ${Jsonparam}    encode    ${ENGINERULEDIC}
    verifyEngineRule    ${Jsonparam}    -1

verify_valid_rule
    [Documentation]    Verify a rule with valid contents.
    ${ENGINERULEDIC.content}    set variable    package rule20170001
    ${Jsonparam}    encode    ${ENGINERULEDIC}
    verifyEngineRule    ${Jsonparam}

deploy_invalid_rule
    [Documentation]    Add a rule with invalid contents to the engine.
    set to dictionary    ${ENGINERULEDIC}    engineid=""
    ${ENGINERULEDIC.content}    set variable    hehehehehehehehe
    ${Jsonparam}    encode    ${ENGINERULEDIC}
    ${response}    deployEngineRule    ${Jsonparam}    -1

deploy_valid_rule
    [Documentation]    Add a rule with valid contents to the engine.
    ${ENGINERULEDIC.content}    set variable    package rule20170002
    ${Jsonparam}    encode    ${ENGINERULEDIC}
    ${response}    deployEngineRule    ${Jsonparam}
    ${responseJson}    to json    ${response.content}
    ${PACKAGENAME}    get from dictionary    ${responseJson}    package
    set suite variable    ${PACKAGENAME}

delete_existing_rule
    [Documentation]    Delete an existing rule using an existing package ID from the engine.
    should not be empty    ${PACKAGENAME}
    deleteEngineRule    ${PACKAGENAME}

delete_non_existing_rule
    [Documentation]    Delete an existing rule using a non-existing package ID from the engine.
    deleteEngineRule    ${PACKAGENAME}    -1
