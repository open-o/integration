*** settings ***
Library           Remote    http://127.0.0.1:8271

*** Variables ***
${resmgr_network_json}    ${SCRIPTS}/../plans/nfvo/sanity-check/jsoninput/resmgr_network.json


*** Test Cases ***
Set MSB_IP in json file
    [Documentation]    Write MSB_IP to JSon file
    Set MSB Value    ${MSB_IP}

resmgr_network_test
    [Documentation]    resmgrNetworkTest
    Replace variables and send REST    ${resmgr_network_json}    null    null

Url Test
    [Documentation]    Check if google.com can be reached
    CheckUrl           http://www.google.com

*** Keywords ***
CheckUrl
    [Arguments]                  ${url}
    Create Session               session              ${url}
    ${resp}=                     Get Request          session                  /
    Should Be Equal As Integers  ${resp.status_code}  200
