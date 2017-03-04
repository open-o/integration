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
# Place the scripts in run order:
# Start MSB
${SCRIPTS}/common-services-microservice-bus/startup.sh i-msb
MSB_IP=`get-instance-ip.sh i-msb`
echo MSB_IP=${MSB_IP}

# Start rulemgt
source ${SCRIPTS}/holmes-rule-management/startup.sh i-rulemgt "127.0.0.1" ${MSB_IP}
RULEMGT_IP=`get-instance-ip.sh i-rulemgt`
echo RULEMGT_IP=${RULEMGT_IP}


# Wait for initialization
for i in {1..20}; do
    curl -sS -m 1 ${RULEMGT_IP}:9101 && curl -sS -m 1 ${MSB_IP}:80 && break
    echo sleep $i
    sleep $i
done


# Start engine-d
source ${SCRIPTS}/holmes-engine-d-management/startup.sh i-engine-d ${RULEMGT_IP} ${MSB_IP}
ENGINE_D_IP=`get-instance-ip.sh i-engine-d`
echo ENGINE_D_IP=${ENGINE_D_IP}



# Wait for initialization
for i in {1..10}; do
    curl -sS -m 1 ${ENGINE_D_IP}:9102 && break
    echo sleep $i
    sleep $i
done
 
#Pass any variables required by Robot test suites in ROBOT_VARIABLES
ROBOT_VARIABLES="-v MSB_IP:${MSB_IP} -v RULEMGT_IP:${RULEMGT_IP} -v ENGINE_D_IP:${ENGINE_D_IP}"

