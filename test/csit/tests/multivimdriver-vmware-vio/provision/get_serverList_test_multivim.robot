*** Settings ***
Resource    ../../common.robot
Library     Collections
Library     RequestsLibrary
Library     json
Library     HttpLibrary.HTTP
Library     Remote    http://127.0.0.1:8271
Library     BuiltIn
Library     OperatingSystem

*** Variables ***
${get_server_list}    ${SCRIPTS}/multivimdriver-vmware-vio/jsoninput/getserverlist.json

*** Test Cases ***
multivimgetvmlist
    [Documentation]    Testcase to get the vm list
    SendRESTAndGetValue    ${get_server_list}    200


