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
echo "Start MSB"
${SCRIPTS}/common-services-microservice-bus/startup.sh i-msb
MSB_IP=`get-instance-ip.sh i-msb`
curl_path='http://'${MSB_IP}'/openoui/microservices/index.html'
sleep_msg="Waiting_connection_for_url_for:i-msb"
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' GREP_STRING="org_openo_msb_route_title" REPEAT_NUMBER="15"

# Start BRS
echo "Start BRS"
echo ${MSB_IP}
${SCRIPTS}/sdno-brs/startup.sh i-brs ${MSB_IP}:80
BRS_IP=`get-instance-ip.sh i-brs`

${SCRIPTS}/sdno-nslcm/startup.sh s-nslcm ${MSB_IP}:80
SERVICE_IP=`get-instance-ip.sh s-nslcm`

SERVICE_PORT='8545'
SERVICE_NAME='sdnonslcm'

# Pass any variables required by Robot test suites in ROBOT_VARIABLES
ROBOT_VARIABLES="-L TRACE -v MSB_IP:${MSB_IP}  -v SERVICE_IP:${SERVICE_IP} -v SERVICE_PORT:${SERVICE_PORT} -v SERVICE_NAME:${SERVICE_NAME}"