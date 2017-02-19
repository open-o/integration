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

Create Lsp with post
    [Documentation]     check api create_lsp if work normally
    Create Session      create_lsp         http://${SERVICE_IP}:${SERVICE_PORT}
    ${post_data}        Get Binary File         ${CURDIR}/create_lsp.json
    Log                 ${post_data}
    ${resp}             Post Request            create_lsp     /openoapi/sdnooptimize/v1/lsp      data=${post_data}
    Should Be Equal     ${resp.status_code}     ${200}
    ${resp_data}        To Json                 ${resp.content}
    ${lsp_uid}        Get From Dictionary     ${resp_data}     lsp_uid
    Log                 ${lsp_uid}

Get All Lsps with get
    [Documentation]     check api get_all_lsps if work normally
    Create Session      get_all_lsps         http://${SERVICE_IP}:${SERVICE_PORT}
    ${resp}             Get Request            get_all_lsps     /openoapi/sdnooptimize/v1/lsp
    Should Be Equal     ${resp.status_code}     ${200}
    ${resp_data}        To Json                 ${resp.content}
    ${lsps}        		Get From Dictionary     ${resp_data}     lsps
    Log                 ${lsps}

Put Lsp with post
    [Documentation]     check api update_lsp if work normally
    Create Session      update_lsp         http://${SERVICE_IP}:${SERVICE_PORT}
    ${post_data}        Get Binary File         ${CURDIR}/update_lsp.json
    Log                 ${post_data}
    ${resp}             Put Request            update_lsp     /openoapi/sdnooptimize/v1/lsp      data=${post_data}
    Should Be Equal     ${resp.status_code}     ${200}

Get An Lsp with get
    [Documentation]     check api get_lsp if work normally
    Create Session      get_lsp         http://${SERVICE_IP}:${SERVICE_PORT}
    ${resp}             Get Request            get_lsp     /openoapi/sdnooptimize/v1/lsp/xyz123
    Should Be Equal     ${resp.status_code}     ${200}
    ${resp_data}        To Json                 ${resp.content}
    ${lsps}        		Get From Dictionary     ${resp_data}     lsps
    Log                 ${lsps}
    
Create Flow Policy with post
    [Documentation]     check api create_flow_policy if work normally
    Create Session      create_flow_policy         http://${SERVICE_IP}:${SERVICE_PORT}
    ${post_data}        Get Binary File         ${CURDIR}/create_flow_policy.json
    Log                 ${post_data}
    ${resp}             Post Request            create_flow_policy     /openoapi/sdnooptimize/v1/flow-policy      data=${post_data}
    Should Be Equal     ${resp.status_code}     ${200}

Get Vsite By Lsp with get
    [Documentation]     check api get_vsite_by_lsp if work normally
    Create Session      get_vsite_by_lsp         http://${SERVICE_IP}:${SERVICE_PORT}
    ${resp}             Get Request            get_vsite_by_lsp     /openoapi/sdnooptimize/v1/vsite/lsp/xyz123
    Should Be Equal     ${resp.status_code}     ${200}

Get Lsp By Vsite with get
    [Documentation]     check api get_lsp_by_vsite if work normally
    Create Session      get_lsp_by_vsite         http://${SERVICE_IP}:${SERVICE_PORT}
    ${resp}             Get Request            get_lsp_by_vsite     /openoapi/sdnooptimize/v1/lsp/vsite/19
    Should Be Equal     ${resp.status_code}     ${200}
  
Delete Flow Policy with del
    [Documentation]     check api del_flow_policy if work normally
    Create Session      del_flow_policy         http://${SERVICE_IP}:${SERVICE_PORT}
    ${resp}             Delete Request            del_flow_policy     /openoapi/sdnooptimize/v1/flow-policy?lsp_uid=xyz123&vsite_uid=19
    Should Be Equal     ${resp.status_code}     ${200}

Delete Lsp with del
    [Documentation]     check api del_lsp if work normally
    Create Session      del_lsp         http://${SERVICE_IP}:${SERVICE_PORT}
    ${resp}             Delete Request            del_lsp     /openoapi/sdnooptimize/v1/lsp/xyz123
    Should Be Equal     ${resp.status_code}     ${200}
