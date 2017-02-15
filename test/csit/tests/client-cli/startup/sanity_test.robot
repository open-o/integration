*** settings ***
Library           OperatingSystem
Library           Collections
Library           BuiltIn
Library           Process
Library           String

*** Variables ***
${command}        docker run -d -i -t -e MSB_ADDR=http://192.168.4.177 -e OPENO_USERNAME=admin -e OPENO_PASSWORD=Changeme_123 openoint/client-cli --name i-cli --entrypoint openo

*** Test Cases ***
List only folder in directory
    ${value} =    Run Process    ${command}     shell=True
    Log    ${value.stdout}
    Log    ${value.rc}
    Should Be Equal    ${value.rc}    ${0}

