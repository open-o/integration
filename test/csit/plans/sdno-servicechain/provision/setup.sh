#!/bin/bash
#
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

# These scripts are sourced by run-csit.sh.
#!/bin/bash

source ${SCRIPTS}/common_functions.sh

# Start MSB
${SCRIPTS}/common-services-microservice-bus/startup.sh i-msb
MSB_IP=`get-instance-ip.sh i-msb`
curl_path='http://'${MSB_IP}'/openoui/microservices/index.html'
sleep_msg="Waiting_connection_for_url_for:i-msb"
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' GREP_STRING="org_openo_msb_route_title" REPEAT_NUMBER="15"

# Start BRS
${SCRIPTS}/sdno-brs/startup.sh i-brs ${MSB_IP}:80
BRS_IP=`get-instance-ip.sh i-brs`

#Start openoint/common-services-drivermanager
run-instance.sh openoint/common-services-drivermanager d-drivermgr " -i -t -e MSB_ADDR=${MSB_IP}:80"
curl_path='http://'${MSB_IP}':80/openoapi/drivermgr/v1/drivers'
sleep_msg="Waiting_connection_for_url_for_DRIVER_MANAGER_load"
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' REPEAT_NUMBER="25" MAX_TIME="60" STATUS_CODE="200" EXCLUDE_STRING

#Start openoint/common-services-extsys
run-instance.sh openoint/common-services-extsys i-common-services-extsys " -i -t -e MSB_ADDR=${MSB_IP}:80"
extsys_ip=`get-instance-ip.sh i-common-services-extsys`
sleep_msg="Waiting_for_i-common-services-extsys"
curl_path='http://'${MSB_IP}':80/openoapi/extsys/v1/vims'
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' REPEAT_NUMBER="25" MAX_TIME="60" STATUS_CODE="200" EXCLUDE_STRING

#Added for SFC_SVC
${SCRIPTS}/sdno-servicechain/startup.sh s-servicechain ${MSB_IP}:80
SVC_IP=`get-instance-ip.sh s-servicechain`

# Copy json files used in tests
cp ${WORKSPACE}/test/csit/${TESTPLAN}/*.json ${WORKDIR}

# Copy the moco runner
cp ${WORKSPACE}/bootstrap/start-service-script/mocomaster/moco-runner-0.11.0-standalone.jar ./

DRIVER_MANAGER_IP=`get-instance-ip.sh d-drivermgr`
SERVICE_IP=`get-instance-ip.sh i-common-services-extsys`
SERVICECHAIN_IP=`get-instance-ip.sh s-servicechain`

ROBOT_VARIABLES="-L TRACE  -v MSB_IP:${MSB_IP} -v SERVICE_IP:${SERVICE_IP} -v DRIVER_MANAGER_IP:${DRIVER_MANAGER_IP} -v SERVICECHAIN_IP:${SERVICECHAIN_IP}"