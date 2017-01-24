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
# This script is sourced by run-csit.sh before the Robot tests are run.

# Start MSB
${SCRIPTS}/common-services-microservice-bus/startup.sh i-msb
MSB_IP=`get-instance-ip.sh i-msb`
echo MSB_IP=${MSB_IP}
sleep 5

# Start Message Broker
${SCRIPTS}/common-services-message-broker/startup.sh i-activemq 
ACTIVEMQ_IP=`get-instance-ip.sh i-activemq`
echo ACTIVEMQ_IP=${ACTIVEMQ_IP}


# Wait for initialization(8086 Service Registration & Discovery, 80 api gateway)
for i in {1..10}; do
    curl -sS -m 1 ${MSB_IP}:8086 && curl -sS -m 1 ${MSB_IP}:80 && curl -sS -m 1 ${ACTIVEMQ_IP}:8161 && break
    echo sleep $i
    sleep $i
done


curl -H "Content-Type: application/json" -X POST -d '{"serviceName": "ActiveMQ","protocol": "TCP","nodes": [{"ip": "'${ACTIVEMQ_IP}'","port": "61616"}]}' http://${MSB_IP}/openoapi/microservices/v1/services

# Pass any variables required by Robot test suites in ROBOT_VARIABLES
ROBOT_VARIABLES="-v MSB_IP:${MSB_IP}"
