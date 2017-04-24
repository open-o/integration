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
# JQ install function
# Comment set up as the test has been disabled. 
#function getRandomIpAddress(){
#    while
#    set $(dd if=/dev/urandom bs=4 count=1 2>/dev/null | od -An -tu1)
#      [ $1 -lt 224 ] &&
#      [ $1 -ne 10 ] &&
#      { [ $1 -ne 192 ] || [ $2 -ne 168 ]; } &&
#      { [ $1 -ne 172 ] || [ $2 -lt 16 ] || [ $2 -gt 31 ]; }
#    do :; done
#    echo $1.$2.$3.$4
#}
#set +x
#Local Var:
#CSAR_DIR=${SCRIPTS}/sdno-lcm/uploadCSAR
#DATA_DIR=${SCRIPTS}/sdno-lcm/data-population
#CREATION_INSTANTIATION_DIR=${SCRIPTS}/sdno-lcm/creation-instantiation
#TERMINATION_DIR=${SCRIPTS}/sdno-lcm/termination
#DELETION_DIR=${SCRIPTS}/sdno-lcm/deletion
#STATE_DIR=${SCRIPTS}/sdno-lcm/state
#source ${SCRIPTS}/common_functions.sh
#
## Pull down MSB, Tosca, and Tosca-catalog docker images
#echo "Pull MSB docker image ..."
#docker pull openoint/common-services-msb
#
#echo "Pull MSS docker image ..."
#docker pull openoint/sdno-service-mss
#
#echo "Pull BRS docker image ..."
#docker pull openoint/sdno-service-brs
#
#echo "Pull LCM docker image ..."
#docker pull openoint/sdno-service-lcm
#
#echo "Pull TOSCA-CATALOG docker image ..."
#docker pull openoint/common-tosca-catalog
#
#echo "Pull TOSCA-ARIA docker image ..."
#docker pull openoint/common-tosca-aria
#
#echo "Pull simulate-sdno-services docker image ..."
#docker pull openoint/simulate-sdno-services
#
## Start Images
#echo "Start MSB docker image ..."
#MSB_PORT="80"
#docker run -d -i -t --name i-msb -p 80:$MSB_PORT openoint/common-services-msb
#MSB_IP=`docker inspect --format '{{ .NetworkSettings.IPAddress }}' i-msb`
#MSB_ADDR=$MSB_IP:$MSB_PORT
#sleep_msg="Waiting_connection_for:i-msb"
#curl_path='http://'${MSB_ADDR}'/api/microservices/v1/swagger.yaml'
#wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE="$sleep_msg" REPEAT_NUMBER="15" STATUS_CODE="200"
#
#echo "Start MSS docker image ..."
#docker run -d -i -t --name i-mss -e MSB_ADDR=$MSB_ADDR openoint/sdno-service-mss
#
#echo "Start BRS docker image ..."
#docker run -d -i -t --name i-brs -e MSB_ADDR=$MSB_ADDR openoint/sdno-service-brs
#
#echo "Start LCM docker image ..."
#docker run -d -i -t --name s-sdno-service-lcm -e MSB_ADDR=$MSB_ADDR openoint/sdno-service-lcm
#
#echo "Start TOSCA-CATALOG docker image ..."
#docker run -d -i -t --name i-catalog -e MSB_ADDR=$MSB_ADDR openoint/common-tosca-catalog
#
#echo "Start TOSCA-ARIA docker image ..."
#docker run -d -i -t --name i-tosca -e MSB_ADDR=$MSB_ADDR openoint/common-tosca-aria
#
#echo "Start SDNO-Simulator ..."
#docker run -d -i -t --name s-simulate-sdno-services -e MSB_ADDR=$MSB_ADDR openoint/simulate-sdno-services
#
##start to wait for different docker to be reachables
##BRS
##echo "BRS..."
#curl_path='http://'$MSB_ADDR'/openoapi/sdnobrs/v1/swagger.json'
#sleep_msg="Waiting_connection_for:i-brs"
#wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE="$sleep_msg" REPEAT_NUMBER="50" STATUS_CODE="200"
##LCM
#echo "LCM..."
#curl_path='http://'$MSB_ADDR'/openoapi/sdnonslcm/v1/swagger.json'
#sleep_msg="Waiting_connection_for:s-lcm"
#wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE="$sleep_msg" REPEAT_NUMBER="50" STATUS_CODE="200"
##TOSCA-CATALOG
#echo "TOSCA-CATALOG..."
#curl_path='http://'$MSB_ADDR'/openoapi/catalog/v1/swagger.json'
#sleep_msg="Waiting_connection_for:i-catalog"
#wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE="$sleep_msg" REPEAT_NUMBER="50" STATUS_CODE="200"
##TOSCA-PARSER
#echo "TOSCA-ARIA..."
#curl_path='http://'$MSB_ADDR'/openoapi/tosca/v1/swagger.json'
#sleep_msg="Waiting_connection_for:i-tosca"
#wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE="$sleep_msg" REPEAT_NUMBER="50" STATUS_CODE="200"
##MSS
#echo "MSS..."
#curl_path='http://'$MSB_ADDR'/openoapi/microservices/v1/services/sdnomss/version/v1'
#sleep_msg="Waiting_connection_for:i-mss"
#wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE="$sleep_msg" REPEAT_NUMBER="100" STATUS_CODE="200"
#
#CONTROLLER_SIMULATOR_IP=`getRandomIpAddress`
#echo "Random ip::$CONTROLLER_SIMULATOR_IP"
#
#echo "Step 3: chmod +x CSAR script..."
#chmod +x $CSAR_DIR/uploadCSAR.sh
#chmod +x $DATA_DIR/import_data_to_esr_brs.sh
#chmod +x $CREATION_INSTANTIATION_DIR/create-ns.sh
#chmod +x $CREATION_INSTANTIATION_DIR/instantiate-ns.sh
#chmod +x $TERMINATION_DIR/terminate_service.sh
#chmod +x $DELETION_DIR/delete_service.sh
#chmod +x $STATE_DIR/service_state.sh
#
#echo "Log memory details # @BEFORE TESTS"
#memory_details
#
#ROBOT_VARIABLES="-L TRACE -v MSB_IP:${MSB_IP} -v SCRIPTS:${SCRIPTS} -v CONTROLLER_SIMULATOR_IP:${CONTROLLER_SIMULATOR_IP}"
ROBOT_VARIABLES="-L TRACE -v MSB_IP:${MSB_IP}"