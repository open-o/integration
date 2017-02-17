*** Settings ***
Resource          ../common/common.robot
Resource          ../../variables/variable.robot
Resource          ../assert/assert-contain.robot
Library           json

*** Variables ***
${vnfm_id}        ${EMPTY}

*** Keywords ***
addVnfm
    [Documentation]    add vnfm
    ${body}    Create Dictionary    name=vnfm    type=tosca    vendor=ZTE    version=v1.0    description=vnfm information
    ...    url=http://127.0.0.1:80/api    userName=username    password=ps    vimId=123012
    ${resp}=    REST.PostRequest    ${EXTSYS_PATH}/vnfms    ${body}
    ${resp1_json}    json.loads    ${resp.content}
    Set Suite Variable    ${vnfm_id}    ${resp1_json['vnfmId']}
    status-code    ${resp}    201

queryVnfmById
    [Documentation]    query vnfm by id ${vnfm_id}
    ${resp}    REST.GetRequest    ${EXTSYS_PATH}/vnfms/${vnfm_id}
    log    ${resp}
    content-dic-contain    ${resp}    vnfmId    ${vnfm_id}    200

queryVnfmInstanceById
    [Documentation]    query vnfm instance by id ${vnfm_id}
    ${resp}    REST.GetRequest    ${EXTSYS_PATH}/common/${vnfm_id}
    log    ${resp}
    content-dic-contain    ${resp}    instanceId    ${vnfm_id}    200

updateVnfm
    [Documentation]    update vnfm ${vnfm_id}
    ${body}    Create Dictionary    name=vnfm_new
    ${resp}    REST.PutRequest    ${EXTSYS_PATH}/vnfms/${vnfm_id}    ${body}
    log    ${resp}
    status-code    ${resp}    200
    ${resp}    REST.GetRequest    ${EXTSYS_PATH}/vnfms/${vnfm_id}
    log    ${resp}
    content-dic-contain    ${resp}    name    vnfm_new    200

queryAllVnfm
    [Documentation]    query all vnfm
    ${resp}    REST.GetRequest    ${EXTSYS_PATH}/vnfms
    log    ${resp}
    content-list-size-greater    ${resp}    1    200

deleteVnfmById
    [Documentation]    delete vnfm by id ${vnfm_id}
    ${resp}    REST.DeleteRequest    ${EXTSYS_PATH}/vnfms/${vnfm_id}
    status-code    ${resp}    204
    ${resp}    REST.GetRequest    ${EXTSYS_PATH}/vnfms/${vnfm_id}
    log    ${resp}
    content-dic-empty    ${resp}    200
