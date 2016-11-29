*** Settings ***
Library           Collections
Library           RequestsLibrary

*** Keywords ***
content-contain
    [Arguments]    ${response}    ${assertContent}    ${statusCode}
    ${detail}    to json    ${response.content}
    should contain    ${detail}    ${assertContent}
    Should Be Equal As Strings    ${response.status_code}    ${statusCode}

status-code
    [Arguments]    ${response}    ${statusCode}
    Should Be Equal As Strings    ${response.status_code}    ${statusCode}

content-dic-contain
    [Arguments]    ${response}    ${dictionary}    ${assertContent}    ${statusCode}
    ${detail}    to json    ${response.content}
    ${detail}    get from dictionary    ${detail}    ${dictionary}
    should contain    ${detail}    ${assertContent}
    Should Be Equal As Strings    ${response.status_code}    ${statusCode}

content-dic-empty
    [Arguments]    ${response}    ${statusCode}
    Should Be Empty    ${response.content}
    Should Be Equal As Strings    ${response.status_code}    ${statusCode}

content-list-size-greater
    [Arguments]    ${response}    ${size}    ${statusCode}
    ${detail}    to json    ${response.content}
    ${respDataLength}    Get Length    ${detail}
    Should Be Equal As Strings    ${response.status_code}    ${statusCode}
    Should Be True    ${respDataLength} >=${size}
