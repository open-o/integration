#!/bin/bash
#
# Copyright 2017 ZTE Corporation.
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

# Start MSB
${SCRIPTS}/common-services-microservice-bus/startup.sh i-msb
MSB_IP=`get-instance-ip.sh i-msb`
echo MSB_IP=${MSB_IP}

# Wait for MSB and gateway instantiation 
for i in {1..20}; do
    curl -sS -m 1 ${MSB_IP}:8086 && curl -sS -m 1 ${MSB_IP}:80 && break
    echo sleep $i
    sleep $i
done

# Start vnfmgr
${SCRIPTS}/gvnfm-vnfmgr/startup.sh i-vnfmgr ${MSB_IP}:80
VNFMGR_IP=`get-instance-ip.sh i-vnfmgr`
echo VNFMGR_IP=${VNFMGR_IP}

# Wait for initialization
for i in {1..20}; do
    curl -sS -m 1 ${VNFMGR_IP}:8803/openoapi/vnfmgr/v1/swagger.json && break
    echo sleep $i
    sleep $i
done

# Pass any variables required by Robot test suites in ROBOT_VARIABLES
ROBOT_VARIABLES="-v MSB_IP:${MSB_IP} -v VNFMGR_IP:${VNFMGR_IP} -v SCRIPTS:${SCRIPTS}"

