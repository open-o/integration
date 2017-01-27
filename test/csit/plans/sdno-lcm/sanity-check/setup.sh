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


${SCRIPTS}/sdno-lcm/startup.sh s-lcm

SERVICE_IP=`get-instance-ip.sh s-lcm`
SERVICE_PORT='8080'
echo ${SERVICE_IP}

curl_path='http://'$SERVICE_IP':'$SERVICE_PORT'/'
sleep_msg="Waiting_connection_of_url_for:"$1
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' GREP_STRING="refused" REPEAT_NUMBER='8'

ROBOT_VARIABLES="-v SERVICE_IP:${SERVICE_IP} -v SERVICE_PORT:${SERVICE_PORT}"