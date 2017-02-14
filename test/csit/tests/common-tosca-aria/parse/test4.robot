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
${input_file_path}      ${SCRIPTS}/../plans/common-tosca-aria/sanity-check/yamlinput/parse_input_empty.yaml

*** Test Cases ***
Parse Test #4 - parse and report error on empty TOSCA template
    [Documentation]        Check if Common TOSCA ARIA is able to handle error, caused by empty TOCSA blueprint validation attempt
    Create Session         msb    http://${MSB_IP}
    Check Response         msb    /openoapi/tosca/v1/validate    ${input_file_path}

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
    Dictionary Should Contain Key       ${response_json}                   issues

    ${response_issues}=                 Get From Dictionary                ${response_json}                   issues
    Should Not Be Empty                 ${response_issues}
    Length Should Be                    ${response_issues}                 ${1}

    ${response_issues_item}=            Get From List                      ${response_issues}                 ${0}
    Dictionary Should Contain Key       ${response_issues_item}            exception
    Dictionary Should Contain Key       ${response_issues_item}            level
    Dictionary Should Contain Key       ${response_issues_item}            column
    Dictionary Should Contain Key       ${response_issues_item}            snippet
    Dictionary Should Contain Key       ${response_issues_item}            location
    Dictionary Should Contain Key       ${response_issues_item}            message
    Dictionary Should Contain Key       ${response_issues_item}            line

    ${response_issues_item_message}=    Get From Dictionary                ${response_issues_item}            message
    Should Be Equal                     ${response_issues_item_message}    presenter not found

    ${response_issues_item_exception}=  Get From Dictionary                ${response_issues_item}            exception
    Should Be Equal                     ${response_issues_item_exception}  aria.parser.presentation.exceptions.PresenterNotFoundError
