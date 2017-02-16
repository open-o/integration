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
Library       OperatingSystem

*** Variables ***
# test parameters configuration
${in_csar_file_name}                   sample_vnf_definition.csar

# test directories and files paths configuration (using parameters)
${in_csar_file_path}                   ${VNFSDK_CSAR_HOME}/${in_csar_file_name}

*** Keywords ***
Validate CSAR
    [Arguments]                        ${csar_file_path}
    ${command}=                        Set Variable                  vnfsdk csar-validate ${in_csar_file_path}
    ${return_code}                     ${output}=                    Run And Return Rc And Output  ${command}
    Log                                ${output}                     console=True
    [Return]                           ${return_code}

Verify Operation Return Code
    [Arguments]                        ${return_code}
    Should Be Equal                    ${return_code}                ${0}

*** Test Cases ***
Use Case 2 - Validate a properly structured CSAR
    [Documentation]
    ...  Preconditions:
    ...  A reference CSAR file provided for the test case
    ...
    ...  Tests steps:
    ...  1.Call csar-validate procedure using the provided CSAR file
    ...  2.Check for errors
    ...
    ...  Expected result:
    ...  Operation ends with no errors

    #Given
    # *** Variables ***

    #When
    ${return_code}=                    Validate CSAR                 ${in_csar_file_path}

    #Then
    Verify Operation Return Code       ${return_code}
