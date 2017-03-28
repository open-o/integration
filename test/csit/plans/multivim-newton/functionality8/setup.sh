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
# Place the scripts in run order:
# Start all process required for executing test case

source ${SCRIPTS}/common_functions.sh

# Start MSB
${SCRIPTS}/common-services-microservice-bus/startup.sh i-msb
MSB_IP=`get-instance-ip.sh i-msb`
curl_path='http://'${MSB_IP}'/openoui/microservices/index.html'
sleep_msg="Waiting_connection_for_url_for:i-msb"
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' GREP_STRING="org_openo_msb_route_title" REPEAT_NUMBER="15"

# start multivim-broker
run-instance.sh openoint/multivim-broker multivim-broker  " -i -t -e MSB_ADDR=${MSB_IP}:80"
extsys_ip=`get-instance-ip.sh multivim-broker`
sleep_msg="Waiting_for_multivim-broker"
curl_path='http://'${MSB_IP}':80/openoapi/multivim/v1/swagger.json'
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' REPEAT_NUMBER=25 GREP_STRING="swagger"

#start multivim-driver-newton
run-instance.sh openoint/multivim-driver-newton multivim-driver-newton  " -i -t -e MSB_ADDR=${MSB_IP}:80"
extsys_ip=`get-instance-ip.sh multivim-driver-newton`
sleep_msg="Waiting_for_multivim-driver-newton"
curl_path='http://'${MSB_IP}':80/openoapi/multivim-newton/v1/swagger.json'
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' REPEAT_NUMBER=25 GREP_STRING="swagger"


echo SCRIPTS

#start simulator newton
docker run -d -i -t --name simulator -e SIMULATOR_JSON=Stubs/testcase/multivimdriver-newton/main.json -p 18009:18009 -p 18008:18008  openoint/simulate-test-docker
SIMULATOR_IP=`get-instance-ip.sh simulator`
sleep_msg="Waiting_for_simulator"
curl_path='http://'${SIMULATOR_IP}':18009/openoapi/extsys/v1/vims'
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' REPEAT_NUMBER=25 GREP_STRING="\["
curl_path='http://'${SIMULATOR_IP}':5000/identity/v2.0/tenants'
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' REPEAT_NUMBER=25 GREP_STRING="tenants"


ROBOT_VARIABLES="-v MSB_IP:${MSB_IP}  -v SCRIPTS:${SCRIPTS}  -v SIMULATOR_IP:${SIMULATOR_IP}"
VIM_ID=c70fec2d-226d-41ae-8a8a-a5b708f6503f
TENANT_ID=93f742f6cd6f4ab9a779d5e474e20a34
ROBOT_VARIABLES+=" -v VIMID:${VIM_ID}  -v TENANTID:${TENANT_ID}"
ROBOT_VARIABLES+=" -v MSB_SERVICES_JSON:${SCRIPTS}/../plans/multivim-newton/jsoninput/register_to_msb.json"
ROBOT_VARIABLES+=" -v CREATE_VOLUME_JSON:${SCRIPTS}/../plans/multivim-newton/jsoninput/multivim_create_volume.json"
robot ${ROBOT_VARIABLES} ${SCRIPTS}/../tests/multivim/provision/register_simulator_to_msb.robot

