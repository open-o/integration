*** Settings ***
Library           Collections
Library           RequestsLibrary
Library           simplejson
Resource          ../../variables/variable.robot

*** Keywords ***
REST.CreateSession
    ${headers}    Create Dictionary    Content-Type    application/json    Accept    application/json
    Create Session    openo    ${LOCAL_URL}    headers=${headers}

REST.PostRequest
    [Arguments]    ${path}    ${data}=
    ${data}    Run Keyword If    "${data}"==""    Create Dictionary    ELSE    simplejson.Dumps    ${data}
    ${resp}    Post Request    openo    ${path}    ${data}
    [Return]    ${resp}

REST.GetRequest
    [Arguments]    ${path}
    ${resp}    Get Request    openo    ${path}
    Return From Keyword    ${resp}
    [Return]    ${resp}

REST.PutRequest
    [Arguments]    ${path}    ${data}=
    ${data}    Run Keyword If    "${data}"==""    Create Dictionary    ELSE    simplejson.Dumps    ${data}
    ${resp}    Put Request    openo    ${path}    ${data}
    [Return]    ${resp}

REST.DeleteRequest
    [Arguments]    ${path}
    ${resp}    Delete Request    openo    ${path}
    [Return]    ${resp}
