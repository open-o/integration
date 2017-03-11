*** Settings ***
Suite Setup
Suite Teardown    Delete All Sessions
Test Timeout      1 minute
Library           demjson
Resource          Rule-Keywords.robot

*** Test Cases ***
