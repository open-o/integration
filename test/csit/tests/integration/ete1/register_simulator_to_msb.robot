*** settings ***
Resource    ../../common.robot
Library     Collections
Library     RequestsLibrary
Library     OperatingSystem
Library     json
Library     BuiltIn
Library     HttpLibrary.HTTP

*** Variables ***
${register_msb_url}    /openoapi/microservices/v1/services
${register_json}    ${SCRIPTS}/../plans/gso/sanity-check/jsoninput/register_to_msb.json
${srvname_inventory}    inventory
${url_inventory}    /openoapi/inventory/v1
${srvname_catalog}    catalog
${url_catalog}    /openoapi/catalog/v1
${srvname_extsys}    extsys
${url_extsys}    /openoapi/extsys/v1
${srvname_nslcm}    nslcm
${url_nslcm}    /openoapi/nslcm/v1
${srvname_sdnonslcm}    sdnonslcm
${url_sdnonslcm}    /openoapi/sdnonslcm/v1
${srvname_wso2bpel}    wso2bpel
${url_wso2bpel}    /openoapi/wso2bpel/v1
*** Test Cases ***
registerInventoryToMsb
    [Documentation]    register inventory simulator to msb
    ${json_value}=     json_from_file      ${register_json}
    Remove From Dictionary  ${json_value}   serviceName
    Set To Dictionary  ${json_value}    serviceName   ${srvname_inventory}
    Remove From Dictionary  ${json_value}   url
    Set To Dictionary  ${json_value}    url   ${url_inventory}
    Remove From Dictionary  ${json_value['nodes'][0]}   ip
    Set To Dictionary  ${json_value['nodes'][0]}    ip   ${SIMULATOR_IP}
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     ${register_msb_url}    ${json_string}
    Log   ${resp}
registerCatalogToMsb
    [Documentation]    register catalog simulator to msb
    ${json_value}=     json_from_file      ${register_json}
    Remove From Dictionary  ${json_value}   serviceName
    Set To Dictionary  ${json_value}    serviceName   ${srvname_catalog}
    Remove From Dictionary  ${json_value}   url
    Set To Dictionary  ${json_value}    url   ${url_catalog}
    Remove From Dictionary  ${json_value['nodes'][0]}   ip
    Set To Dictionary  ${json_value['nodes'][0]}    ip   ${SIMULATOR_IP}
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     ${register_msb_url}    ${json_string}
    Log    ${resp}
registerExtsysToMsb
    [Documentation]    register extsys simulator to msb
    ${json_value}=     json_from_file      ${register_json}
    Remove From Dictionary  ${json_value}   serviceName
    Set To Dictionary  ${json_value}    serviceName   ${srvname_extsys}
    Remove From Dictionary  ${json_value}   url
    Set To Dictionary  ${json_value}    url   ${url_extsys}
    Remove From Dictionary  ${json_value['nodes'][0]}   ip
    Set To Dictionary  ${json_value['nodes'][0]}    ip   ${SIMULATOR_IP}
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     ${register_msb_url}    ${json_string}
    Log    ${resp}
registerNslcmToMsb
    [Documentation]    register nslcm simulator to msb
    ${json_value}=     json_from_file      ${register_json}
    Remove From Dictionary  ${json_value}   serviceName
    Set To Dictionary  ${json_value}    serviceName   ${srvname_nslcm}
    Remove From Dictionary  ${json_value}   url
    Set To Dictionary  ${json_value}    url   ${url_nslcm}
    Remove From Dictionary  ${json_value['nodes'][0]}   ip
    Set To Dictionary  ${json_value['nodes'][0]}    ip   ${SIMULATOR_IP}
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     ${register_msb_url}    ${json_string}
    Log    ${resp}
registerSDNONslcmToMsb
    [Documentation]    register sdnonslcm simulator to msb
    ${json_value}=     json_from_file      ${register_json}
    Remove From Dictionary  ${json_value}   serviceName
    Set To Dictionary  ${json_value}    serviceName   ${srvname_sdnonslcm}
    Remove From Dictionary  ${json_value}   url
    Set To Dictionary  ${json_value}    url   ${url_sdnonslcm}
    Remove From Dictionary  ${json_value['nodes'][0]}   ip
    Set To Dictionary  ${json_value['nodes'][0]}    ip   ${SIMULATOR_IP}
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     ${register_msb_url}    ${json_string}
    Log    ${resp}
registerWso2ToMsb
    [Documentation]    register sdnonslcm simulator to msb
    ${json_value}=     json_from_file      ${register_json}
    Remove From Dictionary  ${json_value}   serviceName
    Set To Dictionary  ${json_value}    serviceName   ${srvname_wso2bpel}
    Remove From Dictionary  ${json_value}   url
    Set To Dictionary  ${json_value}    url   ${url_wso2bpel}
    Remove From Dictionary  ${json_value['nodes'][0]}   ip
    Set To Dictionary  ${json_value['nodes'][0]}    ip   ${SIMULATOR_IP}
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     ${register_msb_url}    ${json_string}
    Log    ${resp}