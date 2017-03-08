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
# These scripts are sourced by run-csit.sh

source ${SCRIPTS}/common_functions.sh

# Start MSB
${SCRIPTS}/common-services-microservice-bus/startup.sh i-msb
MSB_IP=`get-instance-ip.sh i-msb`

curl_path='http://'${MSB_IP}'/api/microservices/v1/swagger.yaml'
sleep_msg="Waiting_connection_for_url_for:i-msb"
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE=$sleep_msg GREP_STRING="MicroService Bus rest API" REPEAT_NUMBER="10"

${SCRIPTS}/sdno-lcm/startup.sh s-lcm

SERVICE_IP=`get-instance-ip.sh s-lcm`
SERVICE_PORT='8554'
echo ${SERVICE_IP}

curl_path='http://'$SERVICE_IP':'$SERVICE_PORT'/'
sleep_msg="Waiting_connection_of_url_for:s-lcm"
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE=$sleep_msg GREP_STRING="refused" EXCLUDE_STRING REPEAT_NUMBER="15" MAX_TIME=30

ROBOT_VARIABLES="-L TRACE -v MSB_IP:${MSB_IP} -v SERVICE_IP:${SERVICE_IP} -v SERVICE_PORT:${SERVICE_PORT}"