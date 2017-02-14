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
