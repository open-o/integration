*** settings ***
Resource    ../../common.robot
Library           Collections
Library           RequestsLibrary
Library           OperatingSystem
Library           json
Library           BuiltIn
Library           HttpLibrary.HTTP

*** Variables ***
${register_json}    ${SCRIPTS}/multivimdriver-vmware-vio/jsoninput/registerToMsb.json
${register_msb_url}    /openoapi/microservices/v1/services


*** Test Cases ***

Register Simulator To Msb
    [Documentation]    register  simulator to msb
    ${json_value}=     json_from_file      ${register_json}
    Remove From Dictionary  ${json_value}   serviceName
    Set To Dictionary  ${json_value}    serviceName   ${SIMULATOR_NAME}
    Remove From Dictionary  ${json_value}   url
    Set To Dictionary  ${json_value}    url   ${SIMULATOR_URL}
    Remove From Dictionary  ${json_value['nodes'][0]}   ip
    Set To Dictionary  ${json_value['nodes'][0]}    ip   ${SIMULATOR_IP}
    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     ${register_msb_url}    ${json_string}
    Log    ${resp}
