*** Settings ***
Library     OperatingSystem
Library     Collections                                                            
Library     RequestsLibrary


*** Test Cases ***
Service Url Test
    [Documentation]     Check if ${SERVICE_IP}:${SERVICE_PORT}/swagger/spec.json ok
    Create Session      url_check               http://${SERVICE_IP}:${SERVICE_PORT}
    ${result}           Get Request             url_check       /swagger/spec.json
    Should Be Equal     ${result.status_code}   ${200}

Create Vsite with post
    [Documentation]     check api create_vsite if work normally
    Create Session      create_vsite         http://${SERVICE_IP}:${SERVICE_PORT}
    ${post_data}        Get Binary File         ${CURDIR}/create_vsite.json
    Log                 ${post_data}
    ${resp}             Post Request            create_vsite     /openoapi/sdnovsitemgr/v1/vsite      data=${post_data}
    Should Be Equal     ${resp.status_code}     ${200}
    ${resp_data}        To Json                 ${resp.content}
    ${vsite_uid}        Get From Dictionary     ${resp_data}     vsite_uid
    Log                 ${vsite_uid}

Get Vsite with get
    [Documentation]     check api get_vsite if work normally
    Create Session      get_vsite         http://${SERVICE_IP}:${SERVICE_PORT}
    ${resp}             Get Request            get_vsite     /openoapi/sdnovsitemgr/v1/vsite/abc
    Should Be Equal     ${resp.status_code}     ${200}
    ${resp_data}        To Json                 ${resp.content}
    ${vsites}        		Get From Dictionary     ${resp_data}     vsites
    Log                 ${vsites}

Put Vsite with post
    [Documentation]     check api update_vsite if work normally
    Create Session      update_vsite         http://${SERVICE_IP}:${SERVICE_PORT}
    ${post_data}        Get Binary File         ${CURDIR}/update_vsite.json
    Log                 ${post_data}
    ${resp}             Put Request            update_vsite     /openoapi/sdnovsitemgr/v1/vsite      data=${post_data}
    Should Be Equal     ${resp.status_code}     ${200}

Create Flow with post
    [Documentation]     check api create_flow if work normally
    Create Session      create_flow         http://${SERVICE_IP}:${SERVICE_PORT}
    ${post_data}        Get Binary File         ${CURDIR}/create_flow.json
    Log                 ${post_data}
    ${resp}             Post Request            create_flow     /openoapi/sdnovsitemgr/v1/flow      data=${post_data}
    Should Be Equal     ${resp.status_code}     ${200}

Put Flow with post
    [Documentation]     check api update_flow if work normally
    Create Session      update_flow         http://${SERVICE_IP}:${SERVICE_PORT}
    ${post_data}        Get Binary File         ${CURDIR}/update_flow.json
    Log                 ${post_data}
    ${resp}             Put Request            update_flow     /openoapi/sdnovsitemgr/v1/flow      data=${post_data}
    Should Be Equal     ${resp.status_code}     ${200}

Delete Flow with post
    [Documentation]     check api delete_flow if work normally
    Create Session      delete_flow         http://${SERVICE_IP}:${SERVICE_PORT}
    ${resp}             Delete Request            delete_flow     /openoapi/sdnovsitemgr/v1/flow/abc
    Should Be Equal     ${resp.status_code}     ${200}
    
Delete Vsite with get
    [Documentation]     check api del_vsite if work normally
    Create Session      del_vsite         http://${SERVICE_IP}:${SERVICE_PORT}
    ${resp}             Delete Request            del_vsite     /openoapi/sdnovsitemgr/v1/vsite/abc
    Should Be Equal     ${resp.status_code}     ${200}

