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
${in_csar_file_name}                   sample_vnf_definition_no_metadata.csar
${out_csar_dir_name}                   test4_result

# test directories and files paths configuration (using parameters)
${test_dir_path}                       ${VNFSDK_TEMP_DIR}
${in_csar_file_path}                   ${VNFSDK_CSAR_HOME}/${in_csar_file_name}
${out_csar_dir_path}                   ${test_dir_path}/${out_csar_dir_name}

*** Keywords ***
Open CSAR
    [Arguments]                        ${csar_file_path}             ${csar_extract_dir_path}
    ${command}=                        Set Variable                  vnfsdk csar-open -d ${csar_extract_dir_path} ${csar_file_path}
    ${return_code}=                    Run And Return Rc             ${command}
    [Return]                           ${return_code}

Verify Operation Return Code
    [Arguments]                        ${return_code}
    Should Be True                     ${return_code} > ${0}

*** Test Cases ***
Use Case 4 - Package invalid structure into CSAR - Attempt should end with error infomration
    [Documentation]
    ...  Preconditions:
    ...  A malformed CSAR file is provided
    ...
    ...  Tests steps:
    ...  1.Attempt to extract the malformed CSAR file
    ...
    ...  Expected result:
    ...  Operation ends with error

    #Given
    # *** Variables ***

    #When
    ${return_code}=                    Open CSAR                     ${in_csar_file_path}          ${out_csar_dir_path}

    #Then
    Verify Operation Return Code       ${return_code}