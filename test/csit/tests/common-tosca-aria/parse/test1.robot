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
Library       RequestsLibrary
Library       OperatingSystem
Library       json

*** Variables ***
${input_file_path}     ${SCRIPTS}/../plans/common-tosca-aria/sanity-check/yamlinput/parse_input.yaml

*** Test Cases ***
Parse Test #1 - parse a valid TOSCA template
    [Documentation]        Check if Common TOSCA ARIA is able to parse valid TOSCA blueprint
    Create Session         msb              http://${MSB_IP}
    Check Response         msb              /openoapi/tosca/v1/validate    ${input_file_path}

*** Keywords
Check Response
    #Given
    [Arguments]                   ${session}           ${uri}          ${file_path}
    ${payload}=                   Get File             ${file_path}

    #When
    ${resp}=                      Post Request         ${session}      ${uri}         data=${payload}

    #Then
    Should Be Equal As Integers   ${resp.status_code}  200

    ${response_json}=             json.loads           ${resp.content}
    Should Be Empty               ${response_json}
