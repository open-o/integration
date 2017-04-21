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

# Start ESR
run-instance.sh openoint/common-services-extsys i-esr "-e MSB_ADDR=${MSB_IP}:80"
ESR_IP=`get-instance-ip.sh i-esr`
echo ESR_IP=${ESR_IP}
sleep_msg="Waiting_for_ESR (External System Registration)"
curl_path='http://'${MSB_IP}':80/openoapi/extsys/v1/sdncontrollers'
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' REPEAT_NUMBER=25 GREP_STRING="\["

# Start Driver Manager
run-instance.sh openoint/common-services-drivermanager i-driver-manager "-e MSB_ADDR=${MSB_IP}:80"
DRIVER_MANAGER_IP=`get-instance-ip.sh i-driver-manager`
echo DRIVER_MANAGER_IP=${DRIVER_MANAGER_IP}
sleep_msg="Waiting_for_driver-manager"
curl_path='http://'${MSB_IP}':80/openoapi/drivermgr/v1/drivers'
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' REPEAT_NUMBER=25 GREP_STRING="\["



# Start catalog
${SCRIPTS}/common-tosca-catalog/startup.sh i-catalog ${MSB_IP}:80
CATALOG_IP=`get-instance-ip.sh i-catalog`
echo CATALOG_IP=${CATALOG_IP}
curl_path='http://'${MSB_IP}':80/openoapi/microservices/v1/services'
sleep_msg="Waiting_for Catalog... "
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE="$sleep_msg" REPEAT_NUMBER="100" GREP_STRING="catalog"

# Start parser
run-instance.sh openoint/common-tosca-aria catalog-parser "-e MSB_ADDR=${MSB_IP}:80"
PARSER_IP=`get-instance-ip.sh catalog-parser`
echo PARSER_IP=${PARSER_IP}
curl_path='http://'${MSB_IP}':80/openoapi/microservices/v1/services'
sleep_msg="Waiting_for Aria Parser... "
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE="$sleep_msg" REPEAT_NUMBER="100" GREP_STRING="tosca"

# Start wso2
run-instance.sh openoint/common-services-wso2ext i-wso2bpel "-e MSB_ADDR=${MSB_IP}:80"
WSO2BPEL_IP=`get-instance-ip.sh i-wso2bpel`
echo WSO2BPEL_IP=${WSO2BPEL_IP}
curl_path='http://'${MSB_IP}':80/openoapi/microservices/v1/services'
sleep_msg="Waiting_for wso2bpel-ext... "
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE="$sleep_msg" REPEAT_NUMBER="100" GREP_STRING="wso2"

# Start inventory
source ${SCRIPTS}/common-tosca-inventory/startup.sh i-inventory ${MSB_IP}
INVENTORY_IP=`get-instance-ip.sh i-inventory`
echo INVENTORY_IP=${INVENTORY_IP}
INV_ADDR=$INVENTORY_IP
curl_path='http://'${MSB_IP}':80/openoapi/microservices/v1/services'
sleep_msg="Waiting_for Inventory... "
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE="$sleep_msg" REPEAT_NUMBER="100" GREP_STRING="inventory"


# Start servicegateway
run-instance.sh openoint/gso-service-gateway gso-sgw " -i -t -e MSB_ADDR=${MSB_IP}:80"
sleep_msg="Waiting_for_gso-sgw"
curl_path='http://'${MSB_IP}':80/openoapi/servicegateway/v1/domains'
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' REPEAT_NUMBER=15 GREP_STRING="\["

#Start gso
run-instance.sh openoint/gso-service-manager gso " -i -t -e MSB_ADDR=${MSB_IP}:80 -e MYSQL_ADDR=${INV_ADDR}:3306"
sleep_msg="Waiting_for_gso-sgw"
curl_path='http://'${MSB_IP}':80/openoapi/gso/v1/services'
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' REPEAT_NUMBER=25 GREP_STRING="\["


#Start sdno micro-services
./setup_sdno.sh ${MSB_IP}:80 ${INVENTORY_IP}:3306

#Start sdn-hub drivers
./setup_sdnhub.sh ${MSB_IP}:80


echo SCRIPTS
# Pass any variables required by Robot test suites in ROBOT_VARIABLES
ROBOT_VARIABLES="-v MSB_IP:${MSB_IP}  -v SCRIPTS:${SCRIPTS}"


#run simulator
docker run -d -i -t --name gso_csit_simulator -e SIMULATOR_JSON=Stubs/testcase/gso/main.json -p 18009:18009 -p 18008:18008  openoint/simulate-test-docker
SIMULATOR_IP=`get-instance-ip.sh gso_csit_simulator`
sleep_msg="Waiting_for_simulator"
curl_path='http://'${SIMULATOR_IP}':18009/openoapi/extsys/v1/vims'
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' REPEAT_NUMBER=15 GREP_STRING="\["

# Pass any variables required by Robot test suites in ROBOT_VARIABLES
ROBOT_VARIABLES="-v MSB_IP:${MSB_IP}  -v SCRIPTS:${SCRIPTS}  -v SIMULATOR_IP:${SIMULATOR_IP} -v CATALOG_IP:${CATALOG_IP} -v PORT:8200"
