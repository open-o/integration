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
docker pull openoint/common-services-msb
docker pull openoint/sdno-service-lcm

docker run -d -i -t --name i-msb -p 80:80 openoint/common-services-msb
MSB_IP=`get-instance-ip.sh i-msb`

curl_path='http://'${MSB_IP}'/api/microservices/v1/swagger.yaml'
sleep_msg="Waiting_connection_for_url_for:i-msb"
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE="$sleep_msg" GREP_STRING="MicroService Bus rest API" REPEAT_NUMBER="10"
echo "delay msb start and lcm start by 20 seconds"

docker run -d -i -t --name s-lcm -e MSB_ADDR="${MSB_IP}:80" openoint/sdno-service-lcm
curl_path='http://'${MSB_IP}'/openoapi/sdnonslcm/v1/swagger.json'
sleep_msg="Waiting_connection_of_url_for:s-lcm"
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE="$sleep_msg" REPEAT_NUMBER="60" STATUS_CODE="200"

ROBOT_VARIABLES="-L TRACE -v MSB_IP:${MSB_IP}"