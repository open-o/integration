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
# $1 nickname for the zte sptn driver instance
# $2 IP address of MSB
source ${SCRIPTS}/common_functions.sh
echo $@

#Start DRIVER ZTE SPTN
echo Starting driver zte sptn
run-instance.sh openoint/sdnhub-driver-zte-sptn i-driver-zte-sptn " -i -t -e MSB_ADDR=$2"
curl_path='http://'$2'/openoapi/drivermgr/v1/drivers'
sleep_msg="Waiting_connection_of_url_for:"$1
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' GREP_STRING="sdno-zte-sptn-driver-1"
