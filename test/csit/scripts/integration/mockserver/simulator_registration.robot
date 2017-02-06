*** settings ***
Library           Remote    http://127.0.0.1:8271
Library           OperatingSystem

*** Variables ***
${register_VIM}    ${SCRIPTS}/integration/mockserver/registerVIM.json
${register_controller}    ${SCRIPTS}/integration/mockserver/registercontroller.json

*** Test Cases ***
Registration for Simulated VIM
    [Documentation]    Replace variables and Create VIM and get vimId
    ${updmap}=    Create Dictionary    MSB_IP=${MSB_IP}    SERVICE_IP=${SIMULATOR_IP}
    ${vim}=    replaceVariablesAndSendREST    ${register_VIM}    ${updmap}    vimId
    Set Suite Variable    ${updmap}
    

Registration for Simulated Controller
    [Documentation]    Replace variables and Create sdncontroller and getsdnControllerId
    ${sdncontroller_ID}=    replaceVariablesAndSendREST    ${register_controller}    ${updmap}    sdnControllerId
    
