*** Settings ***
Resource          ../common/common.robot
Resource          ../../variables/variable.robot
Resource          ../assert/assert-contain.robot
Library           json

*** Variables ***
${ems_id}         ${EMPTY}

*** Keywords ***
addEms
    [Documentation]    add ems
    ${body}    Create Dictionary    name=ems    type=tosca    vendor=ZTE    version=v1.0    description=ems information
    ...    url=http://127.0.0.1:80/api    userName=username    password=ps    productName=emsProduct
    ${resp}=    REST.PostRequest    ${EXTSYS_PATH}/emses    ${body}
    ${resp1_json}    json.loads    ${resp.content}
    Set Suite Variable    ${ems_id}    ${resp1_json['emsId']}
    status-code    ${resp}    201

queryEmsById
    [Documentation]    query ems by id ${ems_id}
    ${resp}    REST.GetRequest    ${EXTSYS_PATH}/emses/${ems_id}
    log    ${resp}
    content-dic-contain    ${resp}    emsId    ${ems_id}    200

queryEmsInstanceById
    [Documentation]    query ems by id ${ems_id}
    ${resp}    REST.GetRequest    ${EXTSYS_PATH}/common/${ems_id}
    log    ${resp}
    content-dic-contain    ${resp}    instanceId    ${ems_id}    200

updatEems
    [Documentation]    update ems ${ems_id}
    ${body}    Create Dictionary    productName=ems_new
    ${resp}    REST.PutRequest    ${EXTSYS_PATH}/emses/${ems_id}    ${body}
    log    ${resp}
    status-code    ${resp}    200
    ${resp}    REST.GetRequest    ${EXTSYS_PATH}/emses/${ems_id}
    log    ${resp}
    content-dic-contain    ${resp}    productName    ems_new    200

queryAllEms
    [Documentation]    query all ems
    ${resp}    REST.GetRequest    ${EXTSYS_PATH}/emses
    log    ${resp}
    content-list-size-greater    ${resp}    1    200

deleteEmsById
    [Documentation]    delete ems by id ${ems_id}
    ${resp}    REST.DeleteRequest    ${EXTSYS_PATH}/emses/${ems_id}
    status-code    ${resp}    204
    ${resp}    REST.GetRequest    ${EXTSYS_PATH}/emses/${ems_id}
    log    ${resp}
    content-dic-empty    ${resp}    200
