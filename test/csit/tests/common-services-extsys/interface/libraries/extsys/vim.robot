*** Settings ***
Resource          ../common/common.robot
Resource          ../../variables/variable.robot
Resource          ../assert/assert-contain.robot
Library           json

*** Variables ***
${vim_id}         ${EMPTY}

*** Keywords ***
addVim
    [Documentation]    add vim
    ${body}    Create Dictionary    name=vim    type=tosca    vendor=ZTE    version=v1.0    description=vim information
    ...    url=http://127.0.0.1:80/api    userName=username    password=ps    domain=admin
    ${resp}=    REST.PostRequest    ${EXTSYS_PATH}/vims    ${body}
    ${resp1_json}    json.loads    ${resp.content}
    Set Suite Variable    ${vim_id}    ${resp1_json['vimId']}
    status-code    ${resp}    201

queryvimById
    [Documentation]    query vim by id ${vim_id}
    ${resp}    REST.GetRequest    ${EXTSYS_PATH}/vims/${vim_id}
    log    ${resp}
    content-dic-contain    ${resp}    vimId    ${vim_id}    200

queryVimInstanceById
    [Documentation]    query vim instance by id ${vim_id}
    ${resp}    REST.GetRequest    ${EXTSYS_PATH}/common/${vim_id}
    log    ${resp}
    content-dic-contain    ${resp}    instanceId    ${vim_id}    200

updatevim
    [Documentation]    update vim ${vim_id}
    ${body}    Create Dictionary    domain=vim_new
    ${resp}    REST.PutRequest    ${EXTSYS_PATH}/vims/${vim_id}    ${body}
    log    ${resp}
    status-code    ${resp}    200
    ${resp}    REST.GetRequest    ${EXTSYS_PATH}/vims/${vim_id}
    log    ${resp}
    content-dic-contain    ${resp}    domain    vim_new    200

queryAllvim
    [Documentation]    query all vim
    ${resp}    REST.GetRequest    ${EXTSYS_PATH}/vims
    log    ${resp}
    content-list-size-greater    ${resp}    1    200

deletevimById
    [Documentation]    delete vim by id ${vim_id}
    ${resp}    REST.DeleteRequest    ${EXTSYS_PATH}/vims/${vim_id}
    status-code    ${resp}    204
    ${resp}    REST.GetRequest    ${EXTSYS_PATH}/vims/${vim_id}
    log    ${resp}
    content-dic-empty    ${resp}    200
