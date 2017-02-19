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

Get Vlinks with get
    [Documentation]     check api get_vlinks if work normally
    Create Session      get_vlinks         http://${SERVICE_IP}:${SERVICE_PORT}
    ${resp}             Get Request            get_vlinks     /openoapi/sdnomonitoring/v1/vlinks
    Should Be Equal     ${resp.status_code}     ${200}
    ${resp_data}        To Json                 ${resp.content}
    ${vlinks}        		Get From Dictionary     ${resp_data}     vlinks
    Log                 ${vlinks}
    
Get node with get
    [Documentation]     check api get_node if work normally
    Create Session      get_node         http://${SERVICE_IP}:${SERVICE_PORT}
    ${resp}             Get Request            get_node     /openoapi/sdnomonitoring/v1/flows/0
    Should Be Equal     ${resp.status_code}     ${200}

    
