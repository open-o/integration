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
${crin_dir}    ${basedir_sdno_lcm}/creation-instantiation
${data_dir}    ${basedir_sdno_lcm}/data-population
${csar_dir}    ${basedir_sdno_lcm}/uploadCSAR
${uuidPattern}    [a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}
${csarId}    -1
${instanceId}    -1
${jobId}    -1

*** test cases ***
CreateAndInstantiate
    [Documentation]    Load CSAR files [output=csarId], verify csarId match uuid pattern, import data to ESR and BSR, Create and instantiate NS.

    ${result} =    Run Process    bash ${csar_dir}/uploadCSAR.sh ${MSB_IP}:80 ${csar_dir} | tail -1    shell=true
    BuiltIn.log    ${result}
    Should Be Empty    ${result.stderr}

    ${csarId} =    Set Variable  ${result.stdout}
    BuiltIn.log    ${csarId}
    Should Not Be Empty    ${csarId}
    Should Match Regexp    ${csarId}    ${uuidPattern}

    ${result} =    Run Process    bash ${data_dir}/import_data_to_esr_brs.sh ${MSB_IP}:80 ${CONTROLLER_SIMULATOR_IP} ${data_dir}/Controllers.json ${data_dir}/Site.json ${data_dir}/ManagedElements.json   shell=true
    BuiltIn.log    ${result.stdout}

    ${result} =    Run Process    bash ${crin_dir}/create-ns.sh ${MSB_IP}:80 ${crin_dir}/Creation.json ${csarId}    shell=true
    BuiltIn.log    ${result}
    BuiltIn.log    ${result.stdout}

    ${instanceId} =    Set Variable  ${result.stdout}
    BuiltIn.log    ${instanceId}
    Should Match Regexp    ${instanceId}    ${uuidPattern}

    ${result} =    Run Process    bash ${crin_dir}/instantiate-ns.sh ${MSB_IP}:80 ${instanceId} ${crin_dir}/Instantiation.json    shell=true

    ${jobId} =    Set Variable  ${result.stdout}
    BuiltIn.log    ${jobId}
#   Should Match Regexp    ${jobId}    ${uuidPattern}