*** Settings ***
Resource          ../common/common.robot
Resource          ../../variables/variable.robot
Resource          ../assert/assert-contain.robot
Library           json

*** Variables ***
${sdnc_id}        ${EMPTY}

*** Keywords ***
addSdnc
    [Documentation]    add sdnc
    ${body}    Create Dictionary    name=sdnc    type=tosca    vendor=ZTE    version=v1.0    description=sdnc information
    ...    url=http://127.0.0.1:80/api    userName=username    password=ps    protocol=HTTP
    ${resp}=    REST.PostRequest    ${EXTSYS_PATH}/sdncontrollers    ${body}
    ${resp1_json}    json.loads    ${resp.content}
    Set Suite Variable    ${sdnc_id}    ${resp1_json['sdnControllerId']}
    status-code    ${resp}    201

querySdncById
    [Documentation]    query sdnc by id ${sdnc_id}
    ${resp}    REST.GetRequest    ${EXTSYS_PATH}/sdncontrollers/${sdnc_id}
    log    ${resp}
    content-dic-contain    ${resp}    sdnControllerId    ${sdnc_id}    200

querySdncInstanceById
    [Documentation]    query sdnc instance by id ${sdnc_id}
    ${resp}    REST.GetRequest    ${EXTSYS_PATH}/common/${sdnc_id}
    log    ${resp}
    content-dic-contain    ${resp}    instanceId    ${sdnc_id}    200

updateSdnc
    [Documentation]    update sdnc ${sdnc_id}
    ${body}    Create Dictionary    protocol=TCP
    ${resp}    REST.PutRequest    ${EXTSYS_PATH}/sdncontrollers/${sdnc_id}    ${body}
    log    ${resp}
    status-code    ${resp}    200
    ${resp}    REST.GetRequest    ${EXTSYS_PATH}/sdncontrollers/${sdnc_id}
    log    ${resp}
    content-dic-contain    ${resp}    protocol    TCP    200

queryAllSdnc
    [Documentation]    query all sdnc
    ${resp}    REST.GetRequest    ${EXTSYS_PATH}/sdncontrollers
    log    ${resp}
    content-list-size-greater    ${resp}    1    200

deleteSdncById
    [Documentation]    delete sdnc by id ${sdnc_id}
    ${resp}    REST.DeleteRequest    ${EXTSYS_PATH}/sdncontrollers/${sdnc_id}
    status-code    ${resp}    204
    ${resp}    REST.GetRequest    ${EXTSYS_PATH}/sdncontrollers/${sdnc_id}
    log    ${resp}
    content-dic-empty    ${resp}    200
