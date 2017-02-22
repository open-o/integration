*** settings ***
Library           OperatingSystem
Library           Collections
Library           BuiltIn
Library           Process
Library           String


*** Variables ***
${command}         /opt/client-cli/bin/openo.sh


*** Test Cases ***
List out all openo commands
        ${value} =    Run Process    ${command}
        Log    ${value.stdout}
        Log    ${value.rc}
        Should Be Equal    ${value.rc}    ${0}

List out openo help commands
        ${value} =    Run Process    ${command}     -h
    Create File    ${CURDIR}/OpenoHelpcmd.txt
    ${result} =    Append To File    OpenoHelpcmd.txt    ${value.stdout}
        Log    ${value.stdout}
        Log    ${value.rc}
        Should Be Equal    ${value.rc}    ${0}

List out openo version commands
        ${value} =    Run Process    ${command}     -v
        Log    ${value.stdout}
        Log    ${value.rc}
        Should Be Equal    ${value.rc}    ${0}

List out registered microservice help in openo commands
        ${value} =    Run Process    ${command}     microservice-list     -h
        Log    ${value.stdout}
        Log    ${value.rc}
        Should Be Equal    ${value.rc}    ${0}


List out registered microservice in openo commands
    Set Environment Variable     OPENO_USERNAME     admin
    Set Environment Variable     OPENO_PASSWORD     Changeme_123
    ${value} =    Run Process    ${command}     microservice-list    -m      http://${MSB_IP}
        Log    ${value.stdout}
        Log    ${value.rc}
        Should Be Equal    ${value.rc}    ${0}

Verify openo help commands
    ${value} =    Run Process    ${command}     -h    shell=True
    ${result} =    OperatingSystem.Get File    OpenoHelpcmd.txt
    Should Be Equal    ${value.stdout}    ${result}
    Should Be Equal    ${value.rc}    ${0}

Verify registered microservice openo help commands
    Set Environment Variable     OPENO_USERNAME     admin
    Set Environment Variable     OPENO_PASSWORD     Changeme_123
    ${value} =    Run Process    ${command}     microservice-list    -m      http://${MSB_IP}     -f     csv     -t
    Get Regexp Matches    ${value.stdout}    auth
    Should Be Equal    ${value.rc}    ${0}
