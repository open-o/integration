*** Settings ***
Suite Setup
Suite Teardown    Delete All Sessions
Test Teardown
Test Timeout      1 minute
Library           demjson
Resource          Engine-Keywords.robot
Resource          ../RuleMgt/Rule-Keywords.robot

*** Test Cases ***
add_valid_rule
    [Documentation]    Add a valid rule.
    ${dict2}    create dictionary    rulename=youbowu031011    description=valid rule!    content=package rule031011    enabled=1
    ${jsonParams}    encode    ${dict2}
    ${response}    createRule    ${jsonParams}
    ${respJson}    to json    ${response.content}
    ${RULEID}    get from dictionary    ${respJson}    ruleid
    set global variable    ${RULEID}
    log    ${RULEID}

deploy_valid_rule
    [Documentation]    Add a rule with valid contents to the engine.
    ${dic4}    create dictionary    content=package rule170312    engineid=""
    ${Jsonparam}    encode    ${dic4}
    ${response}    deployEngineRule    ${Jsonparam}

verify_invalid_rule
    [Documentation]    Verify a rule with invalid contents.
    ${dic1}    create dictionary    content=hahahahahehe
    ${Jsonparam}    encode    ${dic1}
    verifyEngineRule    ${Jsonparam}    -1

delete_existing_rule
    [Documentation]    Delete an existing rule using an existing package ID from the engine.
    deleteEngineRule    rule170312
