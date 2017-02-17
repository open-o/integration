*** Settings ***
Library     OperatingSystem
Library     Collections                                                            
Library     RequestsLibrary

*** Variables ***
${MESSAGE}    Hello, world!

*** Test Cases ***
Service Url Test
    [Documentation]     Check if ${DRIVER_IP}:${DRIVER_PORT}/swagger/spec.json ok
    Create Session      url_check               http://${DRIVER_IP}:${DRIVER_PORT}
    ${result}           Get Request             url_check       /swagger/spec.json
    Should Be Equal     ${result.status_code}   ${200}

Set Nodes Test with post
    [Documentation]     check api set-nodes if work normally
    Create Session      create_setnodes         http://${DRIVER_IP}:${DRIVER_PORT}
    ${post_data}        Get Binary File         ${CURDIR}/setnodes.json
    Log                 ${post_data}
    ${resp}             Post Request            create_setnodes     /openoapi/sdnhub-driver-ct-te/v1/nodes:set-nodes      data=${post_data}
    Should Be Equal     ${resp.status_code}     ${200}
    ${resp_data}        To Json                 ${resp.content}
    ${errcode}          Get From Dictionary     ${resp_data}     err_code
    Should Be Equal As Strings    ${errcode}              0

Create Lsp Test with post
    [Documentation]     check api create-lsp if work normally
    Create Session      create_lsp         			http://${DRIVER_IP}:${DRIVER_PORT}
    ${post_data}        Get Binary File         ${CURDIR}/create_lsp.json
    Log                 ${post_data}
    ${resp}             Post Request            create_lsp     /openoapi/sdnhub-driver-ct-te/v1/lsps:create-lsp      data=${post_data}
    Should Be Equal     ${resp.status_code}     ${200}

Update Lsp Test with post
    [Documentation]     check api update-lsp if work normally
    Create Session      update_lsp         			http://${DRIVER_IP}:${DRIVER_PORT}
    ${post_data}        Get Binary File         ${CURDIR}/update_lsp.json
    Log                 ${post_data}
    ${resp}             Post Request            update_lsp     /openoapi/sdnhub-driver-ct-te/v1/lsps:update-lsp      data=${post_data}
    Should Be Equal     ${resp.status_code}     ${200}

Get Lsp Test with post
    [Documentation]     check api get-lsp if work normally
    Create Session      get_lsp         			http://${DRIVER_IP}:${DRIVER_PORT}
    ${post_data}        Get Binary File         ${CURDIR}/get_lsp.json
    Log                 ${post_data}
    ${resp}             Post Request            get_lsp     /openoapi/sdnhub-driver-ct-te/v1/lsps:get-lsp      data=${post_data}
    Should Be Equal     ${resp.status_code}     ${200}

Create Flow Policy Test with post
    [Documentation]     check api create-flow-policy if work normally
    Create Session      create-flow-policy         			http://${DRIVER_IP}:${DRIVER_PORT}
    ${post_data}        Get Binary File         ${CURDIR}/create-flow-policy.json
    Log                 ${post_data}
    ${resp}             Post Request            create-flow-policy     /openoapi/sdnhub-driver-ct-te/v1/flow-policy:create-flow-policy      data=${post_data}
    Should Be Equal     ${resp.status_code}     ${200}

Get Flow Policy Test with post
    [Documentation]     check api get-flow-policy if work normally
    Create Session      get-flow-policy         			http://${DRIVER_IP}:${DRIVER_PORT}
    ${post_data}        Get Binary File         ${CURDIR}/get-flow-policy.json
    Log                 ${post_data}
    ${resp}             Post Request            get-flow-policy     /openoapi/sdnhub-driver-ct-te/v1/flow-policy:get-flow-policy      data=${post_data}
    Should Be Equal     ${resp.status_code}     ${200}

Delete Flow Policy Test with post
    [Documentation]     check api delete-flow-policy if work normally
    Create Session      delete-flow-policy         			http://${DRIVER_IP}:${DRIVER_PORT}
    ${post_data}        Get Binary File         ${CURDIR}/delete-flow-policy.json
    Log                 ${post_data}
    ${resp}             Post Request            delete-flow-policy     /openoapi/sdnhub-driver-ct-te/v1/flow-policy:delete-flow-policy      data=${post_data}
    Should Be Equal     ${resp.status_code}     ${200}

Delete Lsp Test with post
    [Documentation]     check api delete-lsp if work normally
    Create Session      delete_lsp         			http://${DRIVER_IP}:${DRIVER_PORT}
    ${post_data}        Get Binary File         ${CURDIR}/delete_lsp.json
    Log                 ${post_data}
    ${resp}             Post Request            delete_lsp     /openoapi/sdnhub-driver-ct-te/v1/lsps:delete-lsp      data=${post_data}
    Should Be Equal     ${resp.status_code}     ${200}

Create Link Test with post
    [Documentation]     check api create-link if work normally
    Create Session      create-link         			http://${DRIVER_IP}:${DRIVER_PORT}
    ${post_data}        Get Binary File         ${CURDIR}/create-link.json
    Log                 ${post_data}
    ${resp}             Post Request            create-link     /openoapi/sdnhub-driver-ct-te/v1/links:create-link      data=${post_data}
    Should Be Equal     ${resp.status_code}     ${200}
