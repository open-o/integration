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
curl_path='http://'${MSB_IP}'/openoui/microservices/index.html'
sleep_msg="Waiting_connection_for_url_for:i-msb"
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' STATUS_CODE="200" REPEAT_NUMBER="15"


# Start BRS
${SCRIPTS}/sdno-brs/startup.sh i-brs ${MSB_IP}:80
BRS_IP=`get-instance-ip.sh i-brs`

#Start openoint/common-services-drivermanager
run-instance.sh openoint/common-services-drivermanager d-drivermgr " -i -t -e MSB_ADDR=${MSB_IP}:80"
curl_path='http://'${MSB_IP}':80/openoapi/drivermgr/v1/drivers'
sleep_msg="Waiting_connection_for_url_for_DRIVER_MANAGER_load"
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' STATUS_CODE="200" REPEAT_NUMBER="15"

#Start openoint/common-services-extsys
run-instance.sh openoint/common-services-extsys i-common-services-extsys " -i -t -e MSB_ADDR=${MSB_IP}:80"
extsys_ip=`get-instance-ip.sh i-common-services-extsys`
sleep_msg="Waiting_for_i-common-services-extsys"
curl_path='http://'${MSB_IP}':80/openoapi/extsys/v1/vims'
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' STATUS_CODE="200" REPEAT_NUMBER="25"

#Start VPC
${SCRIPTS}/sdno-vpc/startup.sh s-vpc ${MSB_IP}:80
SERVICE_IP=`get-instance-ip.sh s-vpc`

# Start Huawei Openstack
run-instance.sh openoint/sdno-driver-huawei-openstack d-driver-huawei-openstack " -i -t -e MSB_ADDR=${MSB_IP}:80"

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