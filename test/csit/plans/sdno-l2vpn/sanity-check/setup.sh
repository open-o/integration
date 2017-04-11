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
# These scripts are sourced by run-csit.sh.

source ${SCRIPTS}/common_functions.sh

# Start MSB
${SCRIPTS}/common-services-microservice-bus/startup.sh i-msb
MSB_IP=`get-instance-ip.sh i-msb`
sleep_msg="Waiting_for_MSB_load"
curl_path='http://'${MSB_IP}'/openoui/microservices/index.html'
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE="$sleep_msg" REPEAT_NUMBER=10 GREP_STRING="org_openo_msb_route_title"

echo ${MSB_IP}
${SCRIPTS}/sdno-l2vpn/startup.sh s-l2vpn ${MSB_IP}:80
SERVICE_IP=`get-instance-ip.sh s-l2vpn`

SERVICE_PORT='8509'
SERVICE_NAME='sdnol2vpn'

# Pass any variables required by Robot test suites in ROBOT_VARIABLES
ROBOT_VARIABLES="-L TRACE -v MSB_IP:${MSB_IP}  -v SERVICE_IP:${SERVICE_IP} -v SERVICE_PORT:${SERVICE_PORT} -v SERVICE_NAME:${SERVICE_NAME}"