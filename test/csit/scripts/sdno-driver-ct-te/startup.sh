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
# $1 nickname for the CATALOG instance
# $2 IP address of MSB
source ${SCRIPTS}/common_functions.sh

#Start openoint/sdno-driver-ct-te
run-instance.sh openoint/sdnhub-driver-ct-te $1 " -i -t -e MSB_ADDR=$2"

curl_path='http://'$2'/openoapi/drivermgr/v1/drivers'
sleep_msg="Waiting_url_for_"$1
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' REPEAT_NUMBER=100 GREP_STRING="\[\]" EXCLUDE_STRING
