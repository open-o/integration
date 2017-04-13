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

*** test cases ***
Upload CSAR files sanity check
    [Documentation]    upload CSAR files [output=csarId], verify csarId match uuid pattern

    ${result} =    Run Process    bash ${csar_dir}/uploadCSAR.sh ${MSB_IP}:80 ${TMP_DIR} ${enterprise2DC}| tail -1    shell=true
    BuiltIn.log    ${result}
    Should Be Empty    ${result.stderr}

    ${enterprise2DCcsarId} =    Set Variable  ${result.stdout}
    BuiltIn.log    ${enterprise2DCcsarId}
    Should Not Be Empty    ${enterprise2DCcsarId}
    Should Match Regexp    ${enterprise2DCcsarId}    ${uuidPattern}

    ${result} =    Run Process    bash ${csar_dir}/uploadCSAR.sh ${MSB_IP}:80 ${TMP_DIR} ${underlayl3vpn}| tail -1    shell=true
    BuiltIn.log    ${result}
    Should Be Empty    ${result.stderr}

    ${underlayl3vpncsarId} =    Set Variable  ${result.stdout}
    BuiltIn.log    ${underlayl3vpncsarId}
    Should Not Be Empty    ${underlayl3vpncsarId}
    Should Match Regexp    ${underlayl3vpncsarId}    ${uuidPattern}

    Should Not Be Equal As Strings    ${enterprise2DCcsarId}    ${underlayl3vpncsarId}