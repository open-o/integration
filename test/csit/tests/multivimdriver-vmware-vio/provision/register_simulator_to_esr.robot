*** settings ***
Resource    ../../common.robot
#Library           Remote    http://127.0.0.1:8271
Library           Collections
Library           RequestsLibrary
Library           OperatingSystem
Library           json
Library           BuiltIn
Library           HttpLibrary.HTTP

*** Variables ***
${register_json}    ${SCRIPTS}/multivimdriver-vmware-vio/jsoninput/registerToEsr.json
${register_msb_url}    /openoapi/extsys/v1/vims


*** Test Cases ***

Register Simulator To Esr
    [Documentation]    register  simulator to esr
    ${json_value}=     json_from_file      ${register_json}
    Remove From Dictionary  ${json_value}   url
    Set To Dictionary  ${json_value}    url   http://${SIMULATOR_IP}:5000/v3

    ${json_string}=     string_from_json   ${json_value}
    ${headers}    Create Dictionary    Content-Type=application/json    Accept=application/json
    Create Session    web_session    http://${MSB_IP}    headers=${headers}
    Set Request Body    ${json_string}
    ${resp}=    Post Request    web_session     ${register_msb_url}    ${json_string}
    Log    ${resp}
