*** settings ***
Library           Remote    http://127.0.0.1:8271
Library           BuiltIn
Library           OperatingSystem

*** Variables ***
${register_VIM}    ${SCRIPTS}/integration/mockserver/registerVIM.json
${register_controller}    ${SCRIPTS}/integration/mockserver/registercontroller.json
${register_MSB}    ${SCRIPTS}/integration/mockserver/registerToMsb.json

*** Test Cases ***
Write MSB_IP to JSON
    [Documentation]    Write MSB_IP to JSON file
    Set MSB Value    ${MSB_IP}

Registration for Simulated VIM
    [Documentation]    Replace variables and Create VIM and get vimId
    ${updmap}=    Create Dictionary    MSB_IP=${MSB_IP}    SERVICE_IP=${SIMULATOR_IP}
    ${ESR_VIM_HTTPS}=    Replace variables and send REST    ${register_VIM}    ${updmap}    vimId
    Set Suite Variable    ${updmap}
    Set Global Variable   ${ESR_VIM_HTTPS}

Registration for Simulated Controller
    [Documentation]    Replace variables and Create sdncontroller and getsdnControllerId
    ${ESR_CNTRL_HTTP}=    Replace variables and send REST    ${register_controller}    ${updmap}    sdnControllerId
    Set Global Variable    ${ESR_CNTRL_HTTP}
