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
Library       RequestsLibrary
Library       OperatingSystem
Library       json

*** Variables ***
${input_file_path}      ${SCRIPTS}/../plans/common-tosca-aria/sanity-check/yamlinput/parse_input.yaml
${inputs}               %7B%22test%22%3A%201%7D

*** Test Cases ***
Parse Test #2 - instantiate a model from a valid TOSCA template
    [Documentation]        Check if Common TOSCA ARIA is able to instantiate valid TOSCA blueprint
    Create Session         msb    http://${MSB_IP}
    Check Response         msb    /openoapi/tosca/v1/instance?inputs=${inputs}    ${input_file_path}

*** Keywords
Check Response
    #Given
    [Arguments]                         ${session}                         ${uri}                             ${payload_file_path}
    ${payload}=                         Get File                           ${payload_file_path}

    #When
    ${resp}=                            Post Request                       ${session}                         ${uri}                 data=${payload}

    #Then
    Should Be Equal As Integers         ${resp.status_code}                200

    ${response_json}=                   json.loads                         ${resp.content}
    Should Not Be Empty                 ${response_json}
    Dictionary Should Contain Key       ${response_json}                   instance
    Dictionary Should Contain Key       ${response_json}                   model
    Dictionary Should Contain Key       ${response_json}                   types

    ${response_instance}=               Get From Dictionary                ${response_json}                   instance
    Should Not Be Empty                 ${response_instance}
    Dictionary Should Contain Key       ${response_instance}               inputs
    Dictionary Should Contain Key       ${response_instance}               nodes

    ${response_instance_inptus}=        Get From Dictionary                ${response_instance}               inputs
    Should Not Be Empty                 ${response_instance_inptus}
    Dictionary Should Contain Key       ${response_instance_inptus}        test
    ${response_instance_inptus_test}=   Get From Dictionary                ${response_instance_inptus}        test
    Should Not Be Empty                 ${response_instance_inptus_test}
    Dictionary Should Contain Key       ${response_instance_inptus_test}   value
    ${response_instance_inptus_value}=  Get From Dictionary                ${response_instance_inptus_test}   value
    Should Be Equal                     ${response_instance_inptus_value}  ${1}

    ${response_instance_nodes}=         Get From Dictionary                ${response_instance}               nodes
    Should Not Be Empty                 ${response_instance_nodes}

    ${response_model}=                  Get From Dictionary                ${response_json}                   model
    Should Not Be Empty                 ${response_model}
    Dictionary Should Contain Key       ${response_model}                  inputs
    Dictionary Should Contain Key       ${response_model}                  node_templates

    ${response_model_inptus}=           Get From Dictionary                ${response_model}                  inputs
    Should Not Be Empty                 ${response_model_inptus}

    ${response_model_nt}=               Get From Dictionary                ${response_model}                  node_templates
    Should Not Be Empty                 ${response_model_nt}

    ${response_types}=                  Get From Dictionary                ${response_json}                   types
    Should Not Be Empty                 ${response_types}
    Dictionary Should Contain Key       ${response_types}                  artifact_types
    Dictionary Should Contain Key       ${response_types}                  capability_types
    Dictionary Should Contain Key       ${response_types}                  group_types
    Dictionary Should Contain Key       ${response_types}                  interface_types
    Dictionary Should Contain Key       ${response_types}                  node_types
    Dictionary Should Contain Key       ${response_types}                  policy_trigger_types
    Dictionary Should Contain Key       ${response_types}                  policy_types
    Dictionary Should Contain Key       ${response_types}                  relationship_types
