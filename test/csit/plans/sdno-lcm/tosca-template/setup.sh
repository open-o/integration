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
# Setup commented as the test has been disabled. 
#set +x
##Local Var:
#CSAR_DIR=${SCRIPTS}/sdno-lcm/uploadCSAR
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
#echo "Pull ESR (common-services-extsys) docker image ..."
#docker pull openoint/common-services-extsys
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
#curl_path='http://'$MSB_ADDR'/openoapi/microservices/v1/services/sdnomss/version/v1'
#sleep_msg="Waiting_connection_for:i-mss"
#wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE="$sleep_msg" REPEAT_NUMBER="20" STATUS_CODE="200"
#
#echo "Start BRS docker image ..."
#docker run -d -i -t --name i-brs -e MSB_ADDR=$MSB_ADDR openoint/sdno-service-brs
#curl_path='http://'$MSB_ADDR'/openoapi/sdnobrs/v1/swagger.json'
#sleep_msg="Waiting_connection_for:i-brs"
#wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE="$sleep_msg" REPEAT_NUMBER="20" STATUS_CODE="200"
#
#echo "Start LCM docker image ..."
#docker run -d -i -t --name s-sdno-service-lcm -e MSB_ADDR=$MSB_ADDR openoint/sdno-service-lcm
#curl_path='http://'$MSB_ADDR'/openoapi/sdnonslcm/v1/swagger.json'
#sleep_msg="Waiting_connection_for:s-lcm"
#wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE="$sleep_msg" REPEAT_NUMBER="20" STATUS_CODE="200"
#
#echo "Start TOSCA-CATALOG docker image ..."
#docker run -d -i -t --name i-catalog -e MSB_ADDR=$MSB_ADDR openoint/common-tosca-catalog
#curl_path='http://'$MSB_ADDR'/openoapi/catalog/v1/swagger.json'
#sleep_msg="Waiting_connection_for:i-catalog"
#wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE="$sleep_msg" REPEAT_NUMBER="20" STATUS_CODE="200"
#
#echo "Start TOSCA-ARIA docker image ..."
#docker run -d -i -t --name i-tosca -e MSB_ADDR=$MSB_ADDR openoint/common-tosca-aria
#curl_path='http://'$MSB_ADDR'/openoapi/tosca/v1/swagger.json'
#sleep_msg="Waiting_connection_for:i-tosca"
#wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE="$sleep_msg" REPEAT_NUMBER="20" STATUS_CODE="200"
#
#echo "Start ESR (common-services-extsys) docker image ..."
#docker run -d -i -t --name i-common-services-extsys -e MSB_ADDR=$MSB_ADDR openoint/common-services-extsys
#sleep_msg="Waiting_for_i-common-services-extsys"
#curl_path='http://'${MSB_ADDR}'/openoapi/microservices/v1/services/extsys/version/v1'
#wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE="$sleep_msg" REPEAT_NUMBER="50" STATUS_CODE="200"
#
#echo "chmod +x CSAR script..."
#chmod +x $CSAR_DIR/uploadCSAR.sh
#
#echo "get current time in seconds ..."
#timestamp=`date +%s`
#TMP_DIR=/tmp/CSAR_$timestamp
#echo "Create temporary directory to store fresh csar files under $TMP_DIR...."
#mkdir $TMP_DIR
#chmod 755 $TMP_DIR
#
#CSARFILE=enterprise2DC.csar
#echo "pull $CSARFILE ..."
#for i in $(seq 1 5);
#do
#    echo "Attempt to download csar file number $i/5"
#    curl -m90 "https://gerrit.open-o.org/r/gitweb?p=modelling-csar.git;a=blob;f=csars/sdn-ns/${CSARFILE};h=4b81cd020ec7e94059c68454b81c451613e715bf;hb=refs/heads/master" > $TMP_DIR/${CSARFILE}
#    unzip -t $TMP_DIR/${CSARFILE}
#    if [ $? -eq 0 ];
#    then
#        break
#    elif [ $i -eq 5 ]
#    then
#        echo "/!\ WARNNING::Test expected to fail because the ${CSARFILE} is corrupted"
#    fi
#done
#
#CSARFILE=underlayl3vpn.csar
#echo "pull $CSARFILE ..."
#for j in $(seq 1 5);
#do
#    echo "Attempt to download csar file number $j/5"
#    curl -m90 "https://gerrit.open-o.org/r/gitweb?p=modelling-csar.git;a=blob;f=csars/sdn-ns/${CSARFILE};h=ebb13900ec281b40875442332d5b22afb6ff14ea;hb=refs/heads/master" > $TMP_DIR/${CSARFILE}
#    unzip -t $TMP_DIR/${CSARFILE}
#    if [ $? -eq 0 ];
#    then
#        break
#    elif [ $j -eq 5 ]
#    then
#        echo "/!\ WARNNING::Test expected to fail because the ${CSARFILE} is corrupted"
#    fi
#done
#
#LOG=`ls -l $TMP_DIR`
#echo "LOG INFO::$LOG"
#echo "Log memory details # @BEFORE TESTS"
#memory_details
#
#ROBOT_VARIABLES="-L TRACE -v MSB_IP:${MSB_IP} -v SCRIPTS:${SCRIPTS} -v TMP_DIR:${TMP_DIR} -v enterprise2DC:enterprise2DC.csar -v underlayl3vpn:underlayl3vpn.csar"
ROBOT_VARIABLES="-L TRACE -v MSB_IP:${MSB_IP}" 