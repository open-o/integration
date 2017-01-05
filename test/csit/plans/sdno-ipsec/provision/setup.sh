# These scripts are sourced by run-csit.sh.
#!/bin/bash

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

source ${SCRIPTS}/common_functions.sh

# Start MSB
${SCRIPTS}/common-services-microservice-bus/startup.sh i-msb
MSB_IP=`get-instance-ip.sh i-msb`
curl_path='http://'${MSB_IP}'/openoui/microservices/index.html'
sleep_msg="Waiting_connection_for_url_for:i-msb"
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' GREP_STRING="org_openo_msb_route_title" REPEAT_NUMBER="15"

# Start BRS
echo ${MSB_IP}
${SCRIPTS}/sdno-brs/startup.sh i-brs ${MSB_IP}:80
BRS_IP=`get-instance-ip.sh i-brs`

#Start openoint/common-services-drivermanager
run-instance.sh openoint/common-services-drivermanager d-drivermgr " -i -t -e MSB_ADDR=${MSB_IP}:80"
curl_c='http://'${MSB_IP}':80/openoapi/drivermgr/v1/drivers'
sleep_msg="DRIVER_MANAGER_load"
#wait_curl_driver CURL_COMMAND=$curl_c WAIT_MESSAGE='"$sleep_msg"' REPEAT_NUMBER=15 GREP_STRING="\["

#Start openoint/common-services-extsys
run-instance.sh openoint/common-services-extsys i-common-services-extsys " -i -t -e MSB_ADDR=${MSB_IP}:80"
extsys_ip=`get-instance-ip.sh i-common-services-extsys`
sleep_msg="Waiting_for_i-common-services-extsys"
curl_path='http://'${MSB_IP}':80/openoapi/extsys/v1/vims'
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' REPEAT_NUMBER=25 GREP_STRING="\["

#${SCRIPTS}/sdno-ipsec/startup.sh s-ipsec ${MSB_IP}:80
run-instance.sh openoint/sdno-service-ipsec s-ipsec " -i -t -e MSB_ADDR=${MSB_IP}:80"

#${SCRIPTS}/sdno-driver-huawei-overlay/startup.sh d-driver-huawei-overlay ${MSB_IP}:80
run-instance.sh openoint/sdno-driver-huawei-overlay d-driver-huawei-overlay " -i -t -e MSB_ADDR=${MSB_IP}:80"

#${SCRIPTS}/sdno-driver-huawei-openstack /startup.sh d-driver-huawei-openstack  ${MSB_IP}:80
run-instance.sh openoint/sdno-driver-huawei-openstack d-driver-huawei-openstack " -i -t -e MSB_ADDR=${MSB_IP}:80"

# Copy json files used in tests
cp ${WORKSPACE}/test/csit/${TESTPLAN}/*.json ${WORKDIR}

cp ${WORKSPACE}/bootstrap/start-service-script/mocomaster/moco-runner-0.11.0-standalone.jar ${WORKSPACE}/test/csit/${TESTPLAN}/

# Start moco runner for openstack-dc-controller
cd ${WORKSPACE}/test/csit/${TESTPLAN}/
java -jar moco-runner-0.11.0-standalone.jar http -p 12306 -c moco-openstack-dc-controller.json &
sleep 3     #static wait values are required for moco runner to be able to load everything

# Start moco runner for overlayvpn-access-controller
cd ${WORKSPACE}/test/csit/${TESTPLAN}/
java -jar moco-runner-0.11.0-standalone.jar http -p 18008 -c moco-overlayvpn-access-controller.json &
sleep 3     #static wait values are required for moco runner to be able to load everything

ROBOT_VARIABLES="-v MSB_IP:${MSB_IP}  -v BRS_IP:${BRS_IP} -v SERVICE_PORT:${SERVICE_PORT} -v SERVICE_NAME:${SERVICE_NAME}"
