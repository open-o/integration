*** Settings ***
Library           demjson
Resource          Rule-Keywords.robot

*** Test Cases ***
add_invalid_content_rule
    [Documentation]    Add an invalid rule of which the content is incorrect.
    ${RULEDIC}    create dictionary    rulename=gy2017001    description=create a valid rule!    content=hahahahahaha    enabled=1
    set suite variable    ${RULEDIC}
    remove from dictionary    ${RULEDIC}    content
    set to dictionary     ${RULEDIC}    content=hahahahahaha
    ${jsonParams}    encode    ${RULEDIC}
    ${response}    createRule    ${jsonParams}    -1

add_valid_rule
    [Documentation]    Add a valid rule.
    ${RULEDIC.content}    set variable    package rule2017001
    ${jsonParams}    encode    ${RULEDIC}
    ${response}    createRule    ${jsonParams}
    ${respJson}    to json    ${response.content}
    ${RULEID}    get from dictionary    ${respJson}    ruleid
    set suite variable    ${RULEID}

add_deficient_rule
    [Documentation]    Add an invalid rule of which some mandatory fields are missing.(rulename)
    ${dic}    create dictionary    description=create a valid rule!    content=package rule2017    enabled=1
    ${jsonParams}    encode    ${dic}
    ${response}    createRule    ${jsonParams}    -1

query_rule_with_existing_id
    [Documentation]    Query a rule with an existing ID.
    Comment    ${ruleIdDic}    create dictionary    ruleid=${RULEID}
    Comment    ${ruleidJson}    encode    ${ruleIdDic}
    ${response}    queryConditionRule    {"ruleid":"${RULEID}"}
    ${respJson}    to json    ${response.content}
    ${count}    get from dictionary    ${respJson}    totalcount
    run keyword if    ${count}!=1    fail    Can't find the rule with the specified ruleid.

query_rule_with_non_existing_id
    [Documentation]    Query a rule with a non-existing ID.
    ${response}    queryConditionRule    {"ruleid":"invalidid"}
    ${respJson}    to json    ${response.content}
    ${count}    get from dictionary    ${respJson}    totalcount
    run keyword if    ${count}!=0    fail

query_rule_with_partial_existing_name
    [Documentation]    Query rules with (a part of) an existing name.
    ${response}    queryConditionRule    {"rulename":"gy2017"}
    ${respJson}    to json    ${response.content}
    ${count}    get from dictionary    ${respJson}    totalcount
    run keyword if    ${count}<1    fail    Can't find the rule with (a part of) an existing name

query_rule_with_partial_non_existing_name
    [Documentation]    Query rules with (a part of) a non-existing name.
    ${response}    queryConditionRule    {"rulename":"zte2017"}
    ${respJson}    to json    ${response.content}
    ${count}    get from dictionary    ${respJson}    totalcount
    run keyword if    ${count}!=0    fail

query_rule_with_vaild_status
    [Documentation]    Query rules with a valid status.
    ${response}    queryConditionRule    {"enabled":1}
    ${respJson}    to json    ${response.content}
    ${count}    get from dictionary    ${respJson}    totalcount
    run keyword if    ${count}<0    fail    Can't find the rule with the status valued 1.

query_rule_with_invalid_status
    [Documentation]    Query rules with an invalid status.
    ${response}    queryConditionRule    {"enabled":99}
    ${respJson}    to json    ${response.content}
    ${count}    get from dictionary    ${respJson}    totalcount
    run keyword if    ${count}!=0    fail

query_rule_with_empty_status
    [Documentation]    Query rules with the status left empty.
    ${response}    queryConditionRule    {"enabled":""}
    ${respJson}    to json    ${response.content}
    ${count}    get from dictionary    ${respJson}    totalcount
    run keyword if    ${count}!=0    fail

query_rule_with_combinational_fields
    [Documentation]    Query rules using the combination of different fields.
    remove from dictionary     ${RULEDIC}    description    content
    ${paramJson}    encode    ${RULEDIC}
    ${response}    queryConditionRule    ${paramJson}
    ${respJson}    to json    ${response.content}
    ${count}    get from dictionary    ${respJson}    totalcount
    run keyword if    ${count}<1    fail    Can't find the rules with the combination of different fields.

modify_rule_with_invalid_status
    [Documentation]    modify the rule with an invalid status.
    ${dic}    create dictionary    ruleid=${RULEID}    enabled=88
    ${modifyParam}    encode    ${dic}
    ${modifyResponse}    modifyRule    ${modifyParam}    -1

modify_rule_with_status
    [Documentation]    modify the rule with a valid status.
    ${dic}    create dictionary    ruleid=${RULEID}    enabled=0
    ${modifyParam}    encode    ${dic}
    ${modifyResp}    modifyRule    ${modifyParam}
    ${response}    queryConditionRule    ${modifyParam}
    ${respJson}    to json    ${response.content}
    ${count}    get from dictionary    ${respJson}    totalcount
    run keyword if    ${count}!=1    fail    query rule fails! (can't find the rule modified!)

modify_rule_with_description
    [Documentation]    modify the description of the rule with the new string.
    ${dic}    create dictionary    ruleid=${RULEID}    description=now, i modifying the description of the rule.
    ${modifyParam}    encode    ${dic}
    ${modifyResp}    modifyRule    ${modifyParam}
    ${response}    queryConditionRule    {"ruleid":${RULEID}}    1
    ${respJson}    to json    ${response.content}
    ${count}    get from dictionary    ${respJson}    totalcount
    run keyword if    ${count}!=1    fail    query rule fails!
    ...    ELSE    traversalRuleAttribute    ${respJson}    ${dic}

delete_existing_rule
    [Documentation]    Delete an existing rule.
    deleteRule    {"ruleid":"${RULEID}"}

delete_non_existing_rule
    [Documentation]    Delete a non-existing rule.
    deleteRule    {"ruleid":"${RULEID}"}    -1
