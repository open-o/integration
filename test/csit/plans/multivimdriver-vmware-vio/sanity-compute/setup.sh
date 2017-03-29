#!/bin/bash
#
# Copyright 2016-2017 VMware Technologies Co., Ltd.
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
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' GREP_STRING="org_openo_msb_route_title" REPEAT_NUMBER="10"

#Start openoint/common-services-extsys
run-instance.sh openoint/common-services-extsys extsys " -i -t -e MSB_ADDR=${MSB_IP}:80"
extsys_ip=`get-instance-ip.sh i-common-services-extsys`
#curl_path='http://'$extsys_ip':8100/openoapi/extsys/v1/vims'
curl_path='http://'${MSB_IP}':80/openoapi/extsys/v1/vims'
sleep_msg="Waiting_connection_for_url_for: common-services-extsys"
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' REPEAT_NUMBER=10 GREP_STRING="\["


#Start openoint/common-services-drivermanager
# run-instance.sh openoint/common-services-drivermanager i-drivermgr " -i -t -e MSB_ADDR=${MSB_IP}:80"
# curl_path='http://'${MSB_IP}':80/openoapi/drivermgr/v1/drivers'
# sleep_msg="DRIVER_MANAGER_load"
# wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' REPEAT_NUMBER=10 GREP_STRING="\["

# start multivim-broker
#run-instance.sh openoint/multivim-broker multivim-broker  " -i -t -e MSB_ADDR=${MSB_IP}:80"
#extsys_ip=`get-instance-ip.sh multivim-broker`
#sleep_msg="Waiting_for_multivim-broker"
#curl_path='http://'${MSB_IP}':80/openoapi/multivim/v1/swagger.json'
#wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' REPEAT_NUMBER=10 GREP_STRING="swagger"

#start multivim-driver-vio
run-instance.sh openoint/multivim-driver-vio multivim-driver-vio  " -i -t -e MSB_ADDR=${MSB_IP}:80"
extsys_ip=`get-instance-ip.sh multivim-driver-vio`
sleep_msg="Waiting_for_multivim-driver-vio"
curl_path='http://'${MSB_IP}':80/openoapi/multivim-vio/v1/swagger.json'
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' REPEAT_NUMBER=25 GREP_STRING="swagger"

#run simulator
docker run -d -i -t --name simulator -e SIMULATOR_JSON=Stubs/testcase/multivimdriver-vmware-vio/main.json -p 18009:18009 -p 18008:18008  openoint/simulate-test-docker
#docker run -d -i -t --name simulator -e SIMULATOR_JSON=main.json -p 18009:18009 -p 18008:18008  openoint/simulate-test-docker
SIMULATOR_IP=`get-instance-ip.sh simulator`
sleep_msg="Waiting_for_simulator"
curl_path='http://'${SIMULATOR_IP}':18009/openoapi/extsys/v1/vims'
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' REPEAT_NUMBER=10 GREP_STRING="\["

echo SCRIPTS
# Pass any variables required by Robot test suites in ROBOT_VARIABLES
ROBOT_VARIABLES=$ROBOT_VARIABLES" -v MSB_IP:${MSB_IP}  -v SCRIPTS:${SCRIPTS}  -v SIMULATOR_IP:${SIMULATOR_IP}"
#ROBOT_VARIABLES="-v MSB_IP:${MSB_IP}  -v SCRIPTS:${SCRIPTS}  -v SIMULATOR_IP:${SIMULATOR_IP}"
SIMULATOR_PORT=18009
SIMULATOR_NAME=VIO
SIMULATOR_URL=/openoapi/vio/v1
#VIM_ID=c70fec2d-226d-41ae-8a8a-a5b708f6503f
TENANT_ID=4a419c00cd804ae6935b991b29cac272
ROBOT_VARIABLES=$ROBOT_VARIABLES" -v TENANTID:${TENANT_ID} -v SIMULATOR_PORT:${SIMULATOR_PORT}  -v SIMULATOR_NAME:${SIMULATOR_NAME} -v SIMULATOR_URL:${SIMULATOR_URL}"
ROBOT_VARIABLES+=" -v CREATE_SERVER_JSON:${SCRIPTS}/multivimdriver-vmware-vio/jsoninput/multivim_create_server.json"

#run simulator
#docker run -d -i -t --name simulator -v ${SCRIPTS}/../../../bootstrap/start-service-script/mocomaster:/var/lib/moco   -p 18009:18009 -p 18008:18008  openoint/simulate-test-docker

#SIMULATOR_IP=`get-instance-ip.sh simulator`
#ROBOT_VARIABLES="-v MSB_IP:${MSB_IP}  -v SCRIPTS:${SCRIPTS}  -v SIMULATOR_IP:${SIMULATOR_IP}"
#robot ${ROBOT_VARIABLES} ${SCRIPTS}/../tests/multivim/provision/sanity_test_multivim_broker.robot

# Run Mock server
#run_simulator
