*** Settings ***
Resource    ../../common.robot
Library     Collections
Library     RequestsLibrary
Library     OperatingSystem
Library     json
Library     HttpLibrary.HTTP
Library     Process

*** Variables ***
${basedir_sdno_lcm}    ${SCRIPTS}/sdno-lcm
${csar_dir}    ${basedir_sdno_lcm}/uploadCSAR
${uuidPattern}    [a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}
${csarJsonPattern}    ^\{"csarId":"${uuidPattern}"\}$
${csarJson}    -1

*** test cases ***
CreateAndInstantiate
    ${result} =    Run Process    bash ${csar_dir}/uploadCSAR.sh ${MSB_IP}:80 | tail -1    shell=true
    BuiltIn.log    ${result}
    Should Be Empty    ${result.stderr}
    ${csarJson} =    Set Variable  ${result.stdout}
    BuiltIn.log    ${csarJson}
    Should Not Be Empty    ${csarJson}
    Should Match Regexp    ${csarJson}    ${csarJsonPattern}