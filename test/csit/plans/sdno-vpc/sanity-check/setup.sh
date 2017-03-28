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
MSB_ADDR=${MSB_IP}:80
sleep_msg="Waiting_connection_for:i-msb"
curl_path='http://'${MSB_ADDR}'/api/microservices/v1/swagger.yaml'
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE="$sleep_msg" REPEAT_NUMBER="15" STATUS_CODE="200"

#Start MSS
run-instance.sh openoint/sdno-service-mss i-mss "-e MSB_ADDR=${MSB_ADDR}"
curl_path='http://'${MSB_ADDR}'/openoapi/microservices/v1/services/sdnomss/version/v1'
sleep_msg="Waiting_connection_for_url_for:i-mss"
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE="$sleep_msg" REPEAT_NUMBER="50" STATUS_CODE="200"

#Start BRS
run-instance.sh openoint/sdno-service-brs i-brs " -i -t -e MSB_ADDR=${MSB_ADDR}"
curl_path='http://'${MSB_ADDR}'/openoapi/sdnobrs/v1/swagger.json'
sleep_msg="Waiting_connection_for_url_for:i-brs"
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE="$sleep_msg" REPEAT_NUMBER="50" STATUS_CODE="200"

${SCRIPTS}/sdno-vpc/startup.sh s-vpc ${MSB_ADDR}
SERVICE_IP=`get-instance-ip.sh s-vpc`

SERVICE_PORT='8518'
SERVICE_NAME='sdnovpc'

# Pass any variables required by Robot test suites in ROBOT_VARIABLES
ROBOT_VARIABLES="-L TRACE -v MSB_IP:${MSB_IP}  -v SERVICE_IP:${SERVICE_IP} -v SERVICE_PORT:${SERVICE_PORT} -v SERVICE_NAME:${SERVICE_NAME}"