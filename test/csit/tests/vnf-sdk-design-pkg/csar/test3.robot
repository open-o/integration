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
${in_csar_file_name}                   sample_vnf_definition.csar
${out_csar_dir_name}                   test3_result
${verify_blueprint_name}               sample_vnf_definition
${verify_blueprint_file_name}          blueprint.yaml
${verify_metadata_dir_name}            TOSCA-Metadata
${verify_metadata_file_name}           TOSCA.meta
${verify_metadata_csar_version}        1.1
${verify_metadata_tosca_version}       1.0

# test directories and files paths configuration (using parameters)
${test_dir_path}                       ${VNFSDK_TEMP_DIR}
${in_csar_file_path}                   ${VNFSDK_CSAR_HOME}/${in_csar_file_name}
${out_csar_dir_path}                   ${test_dir_path}/${out_csar_dir_name}
${verify_blueprint_dir_path}           ${VNFSDK_BLUEPRINTS_HOME}/${verify_blueprint_name}
${verify_blueprint_file_path}          ${verify_blueprint_dir_path}/${verify_blueprint_file_name}

*** Keywords ***
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
    Should Contain                     ${metadata_file}              Entry-Definitions: ${verify_blueprint_file_name}
    Should Contain                     ${metadata_file}              TOSCA-Meta-File-Version: '${verify_metadata_tosca_version}'

Verify CSAR Content Structure
    [Arguments]                        ${csar_dir_path}
    ${extraced_dir}=                   List Directory                ${csar_dir_path}
    Length Should Be                   ${extraced_dir}               ${2}
    Should Contain                     ${extraced_dir}               ${verify_metadata_dir_name}
    Should Contain                     ${extraced_dir}               ${verify_blueprint_file_name}

    ${extraced_files}=                 List Files In Directory       ${csar_dir_path}
    Length Should Be                   ${extraced_files}             ${1}
    Should Contain                     ${extraced_files}             ${verify_blueprint_file_name}

Verify CSAR Content
    [Arguments]                        ${csar_dir_path}
    Verify CSAR Content Structure      ${csar_dir_path}
    Verify CSAR Content Blueprint      ${verify_blueprint_file_path}                               ${csar_dir_path}/${verify_blueprint_file_name}
    Verify CSAR Content Metadata       ${csar_dir_path}/${verify_metadata_dir_name}                ${verify_metadata_file_name}

*** Test Cases ***
Use Case 3 - Extract proper CSAR and confirm consistency with original files
    [Documentation]
    ...  Preconditions:
    ...  A reference CSAR file and reference files to compare with  the extracted ones
    ...
    ...  Tests steps:
    ...  1.Extract the reference CSAR file to a temporary directory
    ...  2.Compare the extracted files with the reference ones (they should be identical)
    ...
    ...  Expected result:
    ...  Extracted files are identical as the reference files

    #Given
    # *** Variables ***

    #When
    ${return_code}=                    Open CSAR                     ${in_csar_file_path}          ${out_csar_dir_path}

    #Then
    Verify Operation Return Code       ${return_code}
    Verify CSAR Content                ${out_csar_dir_path}

