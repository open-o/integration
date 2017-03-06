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

source ${SCRIPTS}/common_functions.sh

# Pull down docker images 
${SCRIPTS}/sdno-utils/sdno-pull-images.sh

# Start Images
${SCRIPTS}/sdno-utils/sdno-start-images.sh
MSB_IP=`get-instance-ip.sh i-msb`
LCM_IP=`get-instance-ip.sh s-sdno-service-lcm`
for i in {1..10}; do
    curl -sS -m 1 ${MSB_IP}:80 && curl -sS -m 30 ${LCM_IP}:8554 && break
    echo sleep $i
    sleep $i
done
ROBOT_VARIABLES="-L TRACE -v MSB_IP:${MSB_IP}"

