#!/bin/bash
#
# Copyright 2016-2017 ZTE Corporation.
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
# This script is sourced by run-csit.sh before the Robot tests are run.

# Start MSB
${SCRIPTS}/common-services-microservice-bus/startup.sh i-msb
MSB_IP=`get-instance-ip.sh i-msb`
echo MSB_IP=${MSB_IP}
sleep 5

# Start modeldesigner
${SCRIPTS}/common-tosca-model-designer/startup.sh i-modeldesigner ${MSB_IP}
MODELDESIGNER_IP=`get-instance-ip.sh i-modeldesigner`
echo MODELDESIGNER_IP=${MODELDESIGNER_IP}


# Wait for initialization
for i in {1..10}; do
    curl -sS -m 1 ${MODELDESIGNER_IP}:8202 && curl -sS -m 1 ${MSB_IP}:80 && break
    echo sleep $i
    sleep $i
done

# Pass any variables required by Robot test suites in ROBOT_VARIABLES
ROBOT_VARIABLES="-v MSB_IP:${MSB_IP} -v MODELDESIGNER_IP:${MODELDESIGNER_IP}"