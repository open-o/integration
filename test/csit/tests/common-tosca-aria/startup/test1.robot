# Copyright 2017 Gigaspaces
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License

*** Settings ***
Library       RequestsLibrary

*** Test Cases ***
Liveness Test - check if service is registered
    [Documentation]        Check if Common TOSCA ARIA is registered in the MSB 
    Create Session         msb              http://${MSB_IP}
    CheckUrl               msb              /api/microservices/v1/services/tosca/version/v1 

*** Keywords ***
CheckUrl
    [Arguments]                   ${session}  ${path}
    ${resp}=                      Get Request          ${session}  ${path}
    Should Be Equal As Integers   ${resp.status_code}  200 

