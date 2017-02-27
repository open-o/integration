*** settings ***
Library           OperatingSystem
Library           Collections
Library           BuiltIn
Library           Process
Library           String
Library           SSHLibrary

*** Variables ***
${command}           docker exec -it i-cli bash -c "export OPENO_CLI_HOME=/service; openo"
${hcommand}          docker exec -it i-cli bash -c "export OPENO_CLI_HOME=/service; openo -h"
${vcommand}          docker exec -it i-cli bash -c "export OPENO_CLI_HOME=/service; openo -v"
${mhcommand}         docker exec -it i-cli bash -c "export OPENO_CLI_HOME=/service; openo microservice-list -h"
${rmcommand}         docker exec -it i-cli bash -c "export OPENO_CLI_HOME=/service; openo microservice-list -u admin -p Changeme_123 -m http://192.168.4.47"
${vrmcommand}        docker exec -it i-cli bash -c "export OPENO_CLI_HOME=/service; openo microservice-list -u admin -p Changeme_123 -m http://192.168.4.47 -f csv -t"


*** Test Cases ***
List out all openo commands
        ${value} =    Run   ${command}
        Log    ${value}
    ${values} =    Run And Return Rc    ${command}
        Should Be Equal    ${values}     ${0}

List out openo help commands
        ${value} =    Run   ${hcommand}
    #Create File    ${CURDIR}/OpenoHelpcmd.txt
        ${result} =    Append To File    OpenoHelpcmd.txt    ${value}
        Log    ${value}
    ${values} =    Run And Return Rc    ${hcommand}
        Should Be Equal    ${values}     ${0}

List out openo version commands
        ${value} =    Run   ${vcommand}
        Log    ${value}
    ${values} =    Run And Return Rc    ${vcommand}
        Should Be Equal    ${values}     ${0}

List out registered microservice help in openo commands
        ${value} =    Run   ${mhcommand}
        Log    ${value}
    ${values} =    Run And Return Rc    ${mhcommand}
        Should Be Equal    ${values}     ${0}

List out registered microservice in openo commands
        ${value} =    Run   ${rmcommand}
        Log    ${value}
    ${values} =    Run And Return Rc    ${rmcommand}
        Should Be Equal    ${values}     ${0}

Verify openo help commands
        ${value} =    Run   ${hcommand}
        ${result} =    OperatingSystem.Get File    OpenoHelpcmd.txt
    ${values} =    Run And Return Rc    ${hcommand}
        Should Be Equal    ${value}      ${result}
        Should Be Equal    ${values}     ${0}

Verify registered microservice openo help commands
    ${value} =    Run    ${vrmcommand}
    Get Regexp Matches   ${value}    auth
    ${values} =    Run And Return Rc    ${vrmcommand}
    Should Be Equal      ${values}    ${0}
