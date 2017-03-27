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
function getRandomIpAddress(){
    while
      set $(dd if=/dev/urandom bs=4 count=1 2>/dev/null | od -An -tu1)
      [ $1 -lt 224 ] &&
      [ $1 -ne 10 ] &&
      { [ $1 -ne 192 ] || [ $2 -ne 168 ]; } &&
      { [ $1 -ne 172 ] || [ $2 -lt 16 ] || [ $2 -gt 31 ]; }
    do :; done
    echo $1.$2.$3.$4
}

#Local Var:
CSAR_DIR=${SCRIPTS}/sdno-lcm/uploadCSAR
source ${SCRIPTS}/common_functions.sh

# Pull down docker images
echo "Step 1: Pull docker images ..."
${SCRIPTS}/sdno-utils/sdno-pull-images.sh

# Start Images
echo "Step 2: Start docker images ..."
${SCRIPTS}/sdno-utils/sdno-start-images.sh
MSB_IP=`get-instance-ip.sh i-msb`

CONTROLLER_SIMULATOR_IP=`getRandomIpAddress`
echo "Random ip::$CONTROLLER_SIMULATOR_IP"

echo "Step 3: chmod +x CSAR script..."
chmod +x $CSAR_DIR/uploadCSAR.sh

echo "Log memory details # @BEFORE TESTS"
memory_details

ROBOT_VARIABLES="-L TRACE -v MSB_IP:${MSB_IP} -v SCRIPTS:${SCRIPTS} -v CONTROLLER_SIMULATOR_IP:${CONTROLLER_SIMULATOR_IP}"