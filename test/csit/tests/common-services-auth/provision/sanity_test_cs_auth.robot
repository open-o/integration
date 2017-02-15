*** settings ***
Library           Remote    http://127.0.0.1:8271

*** Variables ***
${auth_login_json}    ${SCRIPTS}/../plans/common-services-auth/sanity-check/jsoninput/csauthlogintestfunc.json
${auth_listuser_json}    ${SCRIPTS}/../plans/common-services-auth/sanity-check/jsoninput/csauthlistusertestfunc.json
${auth_listroles_json}    ${SCRIPTS}/../plans/common-services-auth/sanity-check/jsoninput/csauthlistrolestestfunc.json
${auth_validatetoken_json}    ${SCRIPTS}/../plans/common-services-auth/sanity-check/jsoninput/csauthvalidatetokentestfunc.json


*** Test Cases ***
Set MSB_IP in json file
    [Documentation]    Write MSB_IP to JSon file
    Set MSB Value    ${MSB_IP}

csauthlogintest
    [Documentation]    CSAUTHLoginTest
    SendRESTAndGetValue    ${authlogin_json}    true

csauthlistusertest
    [Documentation]    CSAUTHListUserTest
    SendRESTAndGetValue    ${auth_listuser_json}    null

csauthlistrolestest
    [Documentation]    CSAUTHListRolesTest
    SendRESTAndGetValue    ${auth_listroles_json}    401

csauthvalidatetokentest
    [Documentation]    CSAUTHValidateTokenTest
    SendRESTAndGetValue    ${auth_validatetoken_json}    404
