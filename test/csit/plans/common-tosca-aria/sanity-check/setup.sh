#!/bin/bash
# Copyright 2017 Gigaspaces
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License

# Start MSB
${SCRIPTS}/common-services-microservice-bus/startup.sh i-msb
MSB_IP=`get-instance-ip.sh i-msb`
echo MSB_IP=${MSB_IP}

# Wait for MSB and gateway instantiation 
for i in {1..10}; do
    curl -sS -m 1 ${MSB_IP}:8086 && curl -sS -m 1 ${MSB_IP}:80 && break
    echo sleep $i
    sleep $i
done

run-instance.sh openoint/common-tosca-aria i-common-tosca-aria "-e MSB_ADDR=${MSB_IP}:80"

COMMON_TOSCA_ARIA_IP=`get-instance-ip.sh i-common-tosca-aria`
echo COMMON_TOSCA_ARIA_IP=${COMMON_TOSCA_ARIA_IP}

#Bug workaround
docker exec i-common-tosca-aria sh -c "mkdir /service/env/lib/python2.7/site-packages/aria_extension_open_o/config/ && echo -e 'msb_server_ip: ${MSB_IP}\nmsb_server_port: 80\nparser_service_ip: ${COMMON_TOSCA_ARIA_IP}' > /service/env/lib/python2.7/site-packages/aria_extension_open_o/config/config.yaml"
docker restart i-common-tosca-aria

# Pass any variables required by Robot test suites in ROBOT_VARIABLES
ROBOT_VARIABLES="-v MSB_IP:${MSB_IP}"

