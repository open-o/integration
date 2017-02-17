*** Settings ***
Force Tags        vim
Library           requests
Library           json
Library           Collections
Library           RequestsLibrary
Resource          ../libraries/common/common.robot
Resource          ../libraries/extsys/vim.robot

*** Test Cases ***
addVim
    [Tags]    addVim
    addVim

queryVimById
    [Tags]    queryVimById
    queryVimById

queryvimInstanceById
    [Tags]    queryVimInstanceById
    queryVimInstanceById

updateVim
    [Tags]    updateVim
    updateVim

queryAllVim
    [Tags]    queryAllVim
    queryAllVim

deleteVimById
    [Tags]    deleteVimById
    deleteVimById

*** Keywords ***
