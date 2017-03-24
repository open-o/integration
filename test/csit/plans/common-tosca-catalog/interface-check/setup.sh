#!/bin/bash
#
# Copyright 2016-2017 ZTE Corporation
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

# These scripts are sourced by run-csit.sh.
# kill-instance.sh i-catalog
# kill-instance.sh catalog-msb
# kill-instance.sh catalog-parser
#if [ "$(docker images -q common-tosca-catalog 2> /dev/null)" != "" ]; then
#    docker rmi common-tosca-catalog
#fi
# Start MSB
${SCRIPTS}/common-services-microservice-bus/startup.sh catalog-msb
MSB_IP=`get-instance-ip.sh catalog-msb`
echo MSB_IP=${MSB_IP}
# Start catalog
${SCRIPTS}/common-tosca-catalog/startup.sh i-catalog ${MSB_IP}:80
CATALOG_IP=`get-instance-ip.sh i-catalog`
echo CATALOG_IP=${CATALOG_IP}

# Wait for initialization
for i in {1..10}; do
    curl -sS -m 1 ${CATALOG_IP}:8200/api-doc/index.html && curl -sS -m 1 ${MSB_IP}:80 && break
    echo sleep $i
    sleep $i
done

# Start parser
run-instance.sh openoint/common-tosca-aria catalog-parser "-e MSB_ADDR=${MSB_IP}:80"
PARSER_IP=`get-instance-ip.sh catalog-parser`
echo PARSER_IP=${PARSER_IP}
# Wait for COMMON_TOSCA_ARIA instantiation 
for i in {1..10}; do
    curl -sS -m 1 ${PARSER_IP}:8204 && break
    echo sleep $i
    sleep $i
done

# Pass any variables required by Robot test suites in ROBOT_VARIABLES
ROBOT_VARIABLES="-v MSB_IP:${MSB_IP} -v CATALOG_IP:${CATALOG_IP} -v PORT:8200"
