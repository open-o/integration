#
# Copyright (c) 2017 GigaSpaces Technologies Ltd. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.
#

*** Settings ***
Library       Collections
Library 	  DiffLibrary
Library       OperatingSystem

*** Variables ***
# test parameters configuration
${in_blueprint_name}                   sample_vnf_definition
${in_blueprint_file_name}              blueprint.yaml
${out_csar_file_name}                  test1_result.csar
${verify_csar_dir_name}                test1_result
${verify_metadata_dir_name}            TOSCA-Metadata
${verify_metadata_file_name}           TOSCA.meta
${verify_metadata_csar_version}        1.1
${verify_metadata_tosca_version}       1.0

# test directories and files paths configuration (using parameters)
${test_dir_path}                       ${VNFSDK_TEMP_DIR}
${in_blueprint_dir_path}               ${VNFSDK_BLUEPRINTS_HOME}/${in_blueprint_name}
${in_blueprint_file_path}              ${in_blueprint_dir_path}/${in_blueprint_file_name}
${out_csar_file_path}                  ${test_dir_path}/${out_csar_file_name}
${verify_csar_dir_path}                ${test_dir_path}/${verify_csar_dir_name}

*** Keywords ***
Create CSAR
    [Arguments]                        ${csar_file_path}             ${blueprint_dir_path}         ${blueprint_file_name}
    ${command}=                        Set Variable                  vnfsdk csar-create -d ${csar_file_path} ${blueprint_dir_path} ${blueprint_file_name}
    ${return_code}                     ${output}=                    Run And Return Rc And Output  ${command}
    Log                                ${output}                     console=True
    [Return]                           ${return_code}

Open CSAR
    [Arguments]                        ${csar_file_path}             ${csar_extract_dir_path}
    ${command}=                        Set Variable                  vnfsdk csar-open -d ${csar_extract_dir_path} ${csar_file_path}
    ${return_code}                     ${output}=                    Run And Return Rc And Output  ${command}
    Log                                ${output}                     console=True
    [Return]                           ${return_code}

Verify Operation Return Code
    [Arguments]                        ${return_code}
    Should Be Equal                    ${return_code}                ${0}

Verify CSAR Content Blueprint
    [Arguments]                        ${expected_blueprint_file_path}                             ${actual_blueprint_file_path}
    Diff Files                         ${expected_blueprint_file_path}                             ${actual_blueprint_file_path}

Verify CSAR Content Metadata
    [Arguments]                        ${metadata_dir_path}          ${metadata_file_name}
    ${metadata_dir}=                   List Directory                ${metadata_dir_path}
    Length Should Be                   ${metadata_dir}               ${1}
    Should Contain                     ${metadata_dir}               ${metadata_file_name}

    ${metadata_file}=                  Get File                      ${metadata_dir_path}/${metadata_file_name}
    Should Contain                     ${metadata_file}              CSAR-Version: '${verify_metadata_csar_version}'
    Should Contain                     ${metadata_file}              Created-By: ARIA
    Should Contain                     ${metadata_file}              Entry-Definitions: ${in_blueprint_file_name}
    Should Contain                     ${metadata_file}              TOSCA-Meta-File-Version: '${verify_metadata_tosca_version}'

Verify CSAR Content Structure
    [Arguments]                        ${csar_dir_path}
    ${extraced_dir}=                   List Directory                ${csar_dir_path}
    Length Should Be                   ${extraced_dir}               ${2}
    Should Contain                     ${extraced_dir}               ${verify_metadata_dir_name}
    Should Contain                     ${extraced_dir}               ${in_blueprint_file_name}

    ${extraced_files}=                 List Files In Directory       ${csar_dir_path}
    Length Should Be                   ${extraced_files}             ${1}
    Should Contain                     ${extraced_files}             ${in_blueprint_file_name}

Verify CSAR Content
    [Arguments]                        ${csar_file_path}
    ${return_code}=                    Open CSAR                     ${csar_file_path}             ${verify_csar_dir_path}
    Verify Operation Return Code       ${return_code}
    Verify CSAR Content Structure      ${verify_csar_dir_path}
    Verify CSAR Content Blueprint      ${in_blueprint_file_path}     ${verify_csar_dir_path}/${in_blueprint_file_name}
    Verify CSAR Content Metadata       ${verify_csar_dir_path}/${verify_metadata_dir_name}         ${verify_metadata_file_name}

*** Test Cases ***
Use Case 1 - Package a properly structured files into CSAR
    [Documentation]
    ...  Preconditions:
    ...  A directory that contains a proper YAML file. Additional files may be provided
    ...
    ...  Tests steps:
    ...  1.Call csar-create procedure to create a temporary CSAR file from input directory
    ...  2.Check for errors
    ...  3.Check if the file is not empty
    ...
    ...  Expected result:
    ...  A non-empty CSAR file is created


    #Given
    # *** Variables ***

    #When
    ${return_code}=                    Create CSAR                   ${out_csar_file_path}         ${in_blueprint_dir_path}      ${in_blueprint_file_name}

    #Then
    Verify Operation Return Code       ${return_code}
    Verify CSAR Content                ${out_csar_file_path}
