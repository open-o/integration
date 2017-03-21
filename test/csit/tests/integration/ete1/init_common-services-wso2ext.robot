*** Settings ***
Library       OperatingSystem
Library       RequestsLibrary

*** Test Cases ***
Url Test
    [Documentation]    Check if MSB can be reached
    CheckUrl           http://${MSB_IP}:80/

*** Keywords ***
CheckUrl
    [Arguments]                  ${url}
    Create Session               session              ${url}
    ${resp}=                     Get Request          session                  /
    Should Be Equal As Integers  ${resp.status_code}  200
