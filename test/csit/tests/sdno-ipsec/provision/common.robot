*** Settings ***
Library           Collections
Library           RequestsLibrary

*** Keywords ***
REST.CreateSession
    ${headers}    Create Dictionary    Content-Type    application/json    Accept    application/json
    Create Session    openo    ${URL}    headers=${headers}

#Commented out due to a bug in simplejson
#REST.PostRequest
#    [Arguments]    ${path}    ${data}=
#    ${data}    Run Keyword If    "${data}"==""    Create Dictionary    ELSE    simplejson.Dumps    ${data}
#    ${resp}    Post Request    openo    ${path}    ${data}
#    [Return]    ${resp}

REST.GetRequest
    [Arguments]    ${path}
    ${resp}    Get Request    openo    ${path}
    Return From Keyword    ${resp}
    [Return]    ${resp}

#Commented out due to a bug in simplejson
#REST.PutRequest
#    [Arguments]    ${path}    ${data}=
#    ${data}    Run Keyword If    "${data}"==""    Create Dictionary    ELSE    simplejson.Dumps    ${data}
#    ${resp}    Put Request    openo    ${path}    ${data}
#    [Return]    ${resp}

REST.DeleteRequest
    [Arguments]    ${path}
    ${resp}    Delete Request    openo    ${path}
    [Return]    ${resp}
