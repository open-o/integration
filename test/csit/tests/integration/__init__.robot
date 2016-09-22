*** Settings ***
Documentation    Integration test suites
Library          OperatingSystem
Suite Setup      Do Something    /tmp

*** Variables ***

*** Keywords ***
Do Something
    [Arguments]    ${path}
    Directory Should Exist    ${path}
