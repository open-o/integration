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

#Added simplejson package required for robot tests
pip install simplejson

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
run-instance.sh openoint/sdno-service-brs $1 " -i -t -e MSB_ADDR=${MSB_ADDR}"
curl_path='http://'${MSB_ADDR}'/openoapi/sdnobrs/v1/swagger.json'
sleep_msg="Waiting_connection_for_url_for:i-brs"
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE="$sleep_msg" REPEAT_NUMBER="50" STATUS_CODE="200"

#Start openoint/common-services-drivermanager
run-instance.sh openoint/common-services-drivermanager d-drivermgr " -i -t -e MSB_ADDR=${MSB_ADDR}"
curl_path='http://'${MSB_ADDR}'/openoapi/drivermgr/v1/drivers'
sleep_msg="Waiting_connection_for_url_for_DRIVER_MANAGER_load"
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE="$sleep_msg" STATUS_CODE="200" REPEAT_NUMBER="15"

#Start openoint/common-services-extsys
run-instance.sh openoint/common-services-extsys i-common-services-extsys " -i -t -e MSB_ADDR=${MSB_ADDR}"
extsys_ip=`get-instance-ip.sh i-common-services-extsys`
sleep_msg="Waiting_for_i-common-services-extsys"
curl_path='http://'${MSB_ADDR}'/openoapi/extsys/v1/vims'
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE="$sleep_msg" STATUS_CODE="200" REPEAT_NUMBER="25"

#Start VPC
${SCRIPTS}/sdno-vpc/startup.sh s-vpc ${MSB_ADDR}
SERVICE_IP=`get-instance-ip.sh s-vpc`

# Start Huawei Openstack
run-instance.sh openoint/sdno-driver-huawei-openstack d-driver-huawei-openstack " -i -t -e MSB_ADDR=${MSB_ADDR}"

# Copy json files used in tests
cp ${WORKSPACE}/test/csit/${TESTPLAN}/*.json ${WORKDIR}

# Start moco runner
wget https://repo1.maven.org/maven2/com/github/dreamhead/moco-runner/0.11.0/moco-runner-0.11.0-standalone.jar
java -jar moco-runner-0.11.0-standalone.jar http -p 10002 -c moco-acdc-controller.json &
#Static value required to wait for the moco to start and configure
sleep 5

DRIVER_MANAGER_IP=`get-instance-ip.sh d-drivermgr`
SERVICE_IP=`get-instance-ip.sh i-common-services-extsys`
VPC_IP=`get-instance-ip.sh s-vpc`

ROBOT_VARIABLES="-L TRACE -v MSB_IP:${MSB_IP} -v SERVICE_IP:${SERVICE_IP} -v DRIVER_MANAGER_IP:${DRIVER_MANAGER_IP} -v VPC_IP:${VPC_IP}"