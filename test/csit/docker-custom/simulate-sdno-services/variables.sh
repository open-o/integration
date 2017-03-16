#!/bin/bash
#
# Copyright 2016-2017 Huawei Technologies Co., Ltd.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#File that will contain different variables/values to that will be used in multiple scripts
#Or can be changed withound changing effectively the scripts

#This part contains details of the services
#SERVICE_IP is optained when the docker instance is started

SERVICE_NAME[0]='sdnol2vpn'
SERVICE_PATH[0]='sdnol2vpn'
SERVICE_PORT[0]='8509'
LOG_FILE[0]=''
SERVICE_NAME[1]='sdnol3vpn'
SERVICE_PATH[1]='sdnol3vpn'
SERVICE_PORT[1]='8506'
LOG_FILE[1]=''
SERVICE_NAME[2]='sdnooverlay'
SERVICE_PATH[2]='sdnooverlay'
SERVICE_PORT[2]='8503'
LOG_FILE[2]=''
SERVICE_NAME[3]='sdnoservicechain'
SERVICE_PATH[3]='sdnoservicechain'
SERVICE_PORT[3]='8521'
LOG_FILE[3]=''
SERVICE_NAME[4]='sdnosite'
SERVICE_PATH[4]='sdnolocalsite'
SERVICE_PORT[4]='8548'
LOG_FILE[4]=''
SERVICE_NAME[5]='sdnovpc'
SERVICE_PATH[5]='sdnovpc'
SERVICE_PORT[5]='8518'
LOG_FILE[5]=''