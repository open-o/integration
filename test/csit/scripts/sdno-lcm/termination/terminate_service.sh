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
#use JSON qw( encode_json decode_json );

#### Check arguments
[ $# -ne 3 ] && { echo "Usage: $0 <MSB_ADDR[ipv4:port]> <TERMINATION_DIR[where terminate.json could be found]> <NSINSTANCEID[uuid]>"; exit 1;}

MSB_ADDR=$1
echo $MSB_ADDR
JSON_FILENAME="$2/terminate.json"
echo $JSON_FILENAME
NS_INSTANCE_ID=$3
echo $NS_INSTANCE_ID
#CHECK IF JSON filename IS GIVEN IN COMMAND. "terminate.json" is the default value to avoid breaking exist scripts.

if [ -e $JSON_FILENAME ]
then
    echo "$JSON_FILENAME found and it is a file ..."
else
    echo "$JSON_FILENAME is not a file ...."
    echo "Usage: $0 <MSB_ADDR[ipv4:port]> <TERMINATION_DIR[where terminate.json could be found]>"
    exit 1
fi
body=$(cat $JSON_FILENAME | sed 's/INSTANCE_ID_PLACEHOLDER/'$NS_INSTANCE_ID'/ig')
response=$(curl -v -H 'Content-Type: application/json;charset=UTF-8' -d "$body" http://"$MSB_ADDR"/openoapi/sdnonslcm/v1/ns/path/terminate)
jobId=$(echo ${response} | jq -c '.jobId' | sed 's/\"//g')
echo "$jobId"