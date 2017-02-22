#!/bin/bash
#
# Copyright 2017 Huawei Technologies Co., Ltd.
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
source ${SCRIPTS}/common_functions.sh

# Start MSB
${SCRIPTS}/client-cli/startup.sh i-msb
MSB_IP=`get-instance-ip.sh i-msb`
curl_path='http://'${MSB_IP}'/openoui/microservices/index.html'
sleep_msg="Waiting_connection_for_url_for:i-msb"
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' GREP_STRING="org_openo_msb_route_title" REPEAT_NUMBER="15"

# Start auth
docker run -d -i -t -e MSB_ADDR=$MSB_IP --name i-auth -p 8100:8100 openoint/common-services-auth

# Start client-cli
#docker run -d -i -t -e MSB_ADDR=http://$MSB_IP --name i-cli -e OPENO_USERNAME=admin -e OPENO_PASSWORD=Changeme_123 openoint/client-cli --entrypoint openo

export CLI_ZIP=client-cli-deployment-1.1.0-20170221.090136-5.zip
export OPENO_CLI_HOME=/opt/client-cli

sudo apt-get install unzip -y

wget "https://nexus.open-o.org/content/repositories/snapshots/org/openo/client/cli/client-cli-deployment/1.1.0-SNAPSHOT/$CLI_ZIP" -P $OPENO_CLI_HOME

unzip $OPENO_CLI_HOME/ -d $OPENO_CLI_HOME

chmod -R 766 /opt/client-cli

echo SCRIPTS

# Pass any variables required by Robot test suites in ROBOT_VARIABLES
ROBOT_VARIABLES="-v MSB_IP:${MSB_IP}  -v SCRIPTS:${SCRIPTS}"