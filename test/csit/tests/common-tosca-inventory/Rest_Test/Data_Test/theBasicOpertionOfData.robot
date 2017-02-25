*** Settings ***
Test Setup        Run Keyword    Prepare a test model called transcript
Test Teardown     Run Keyword    Delete useless model
Library           Collections
Library           RequestsLibrary
Library           json
Resource          keyword.txt
Resource          ../Model_Test/keyword.txt

*** Test Cases ***
Add one data for a model
    ${header}    Define the header
    ${dataRecord}    Set Variable    { \ \ "_id":"dataOnly", \ \ "name":"haha", \ \ "grade":97 }
    ${dataRecord}    tojson    ${dataRecord}
    ${responseComment}    Post Request    inventory    /openoapi/inventory/v1/data/transcript    data=${dataRecord}    headers=${header}
    Should Be Equal As Strings    ${responseComment.status_code}    200

Batch add the data for a model
    ${header}    Define the header
    ${multipleData}    Prepare 10 data records
    ${multipleData}    tojson    ${multipleData}
    ${responseComment}    Post Request    inventory    /openoapi/inventory/v1/data/transcript    data=${multipleData}    headers=${header}
    Should Be Equal As Strings    ${responseComment.status_code}    200

Update data by id
    [Setup]    Run Keyword    Prepare 10 data records for transcript
    ${header}    Define the header
    ${updatedData}    Set Variable    { \ \ "_id":"dataOne", \ \ "name":"updatedData", \ \ "grade":60 }
    ${responseContent}    Put Request    inventory    /openoapi/inventory/v1/data/transcript/dataOne    data=${updatedData}    headers=${header}
    Should Be Equal As Strings    ${responseContent.status_code}    200

Query all data of model
    [Setup]    Run Keyword    Prepare 10 data records for transcript
    ${header}    Define the header
    ${responseContent}    Get Request    inventory    /openoapi/inventory/v1/data/transcript    headers=${header}
    Should Be Equal As Strings    ${responseContent.status_code}    200
    Log    ${responseContent.content}

Query the number of data by filter
    [Setup]    Run Keyword    Prepare 10 data records for transcript
    ${header}    Define the header
    ${condition}    Set Variable    {"$and": [{"_id": {"$regex": "data*"}}]}
    ${condition}    toJson    ${condition}
    ${responseContent}    Post Request    inventory    /openoapi/inventory/v1/count/data/transcript    data=${condition}    headers=${header}
    Should Be Equal As Strings    ${responseContent.status_code}    200
    Log    ${responseContent.content}

Query data of model by id
    [Setup]    Run Keyword    Prepare 10 data records for transcript
    ${header}    Define the header
    ${responseContent}    Get Request    inventory    /openoapi/inventory/v1/data/transcript/dataTwo
    Should Be Equal As Strings    ${responseContent.status_code}    200

Query the total number of data for a model
    [Setup]    Run Keyword    Prepare 10 data records for transcript
    ${header}    Define the header
    ${responseContent}    Get Request    inventory    /openoapi/inventory/v1/count/data/transcript
    Should Be Equal As Strings    ${responseContent.status_code}    200

Query data by criteria
    [Setup]    Run Keyword    Prepare 10 data records for transcript
    ${header}    Define the header
    ${queryCondition}    Set Variable    {"offset": 0, "limit": 15, "condition": {"$or": [{"_id": {"$eq": "dataTwo"}}]}}
    ${queryCondition}    toJson    ${queryCondition}
    ${responseContent}    Post Request    inventory    /openoapi/inventory/v1/search/data/transcript    data=${queryCondition}    headers=${header}
    Should Be Equal As Strings    ${responseContent.status_code}    200

Delete data by id
    [Setup]    Run Keyword    Prepare 10 data records for transcript
    ${header}    Define the header
    ${responseContent}    Delete Request    inventory    /openoapi/inventory/v1/data/transcript/dataOne    headers=${header}
    Should Be Equal As Strings    ${responseContent.status_code}    200

Delete data by criteria
    [Setup]    Run Keyword    Prepare 10 data records for transcript
    ${header}    Define the header
    ${deleteCondition}    Set Variable    { \ \ "_id":{ \ \ \ \ "$eq":"data*" \ \ } }
    ${responseContent}    Delete Request    inventory    /openoapi/inventory/v1/data/transcript    data=${deleteCondition}    headers=${header}
    Should Be Equal As Strings    ${responseContent.status_code}    200
