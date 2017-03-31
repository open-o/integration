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
[ $# -ne 3 ] && { echo "Usage: $0 <MSB_ADDR[ipv4:port]> <INSTANCE_ID[uuid]> <JSON_FILE_NAME>"; exit 1;}

#MSB address, ID of the instance to be instantiated, the json file with request body.
MSB_ADDR=$1
INSTANCE_ID=$2
BODY_FILE_NAME=$3

#Read instantiation request from JSON file and replace instance id placeholder with real value
body=$(cat $BODY_FILE_NAME | sed 's/INSTANCE_ID_PLACEHOLDER/'$INSTANCE_ID'/ig')

#prepare curl command. quiet mode is used since we use stdout to return the job id.
response=$(curl -s -X POST -d "$body" -H 'Content-Type: application/json;charset=UTF-8' http://"$MSB_ADDR"/openoapi/sdnonslcm/v1/ns/"$INSTANCE_ID"/instantiate)
echo "RESPONSE::$response"
jobId=$(echo $response | jq '.jobId')

#return job id (needed to query instantiation job status)
echo $jobId