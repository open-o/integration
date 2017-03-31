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
[ $# -ne 3 ] && { echo "Usage: $0 <MSB_ADDR[ipv4:port]> <JSON_FILE_NAME> <JSON_CSAR_ID[{\"csarId\":\"uuid\"}]>"; exit 1;}

####MSB address and the json file with request body.
MSB_ADDR=$1;
BODY_FILE_NAME=$2;
CSAR_ID=$3
all_template_response=$(curl -s -m60 http://"$MSB_ADDR"/openoapi/catalog/v1/servicetemplates?status=Disabled&deletionPending=false)
all_template_size=$(echo $all_template_response | jq '. | length'-1)
templateId=null
if [ $all_template_size -eq 0 ]
then
    tempCsarId=$(echo $all_template_response | jq '.[0].csarId'| sed 's/\"//g')
    if [ "$tempCsarId" == "$CSAR_ID" ]
    then
        templateId=$(echo $all_template_response | jq '.[0].serviceTemplateId'| sed 's/\"//g')
    fi
else
    for i in $(seq 0 $all_template_size);
    do
        tempCsarId=$(echo $all_template_response | jq '.['$i'].csarId'| sed 's/\"//g')
        if [ "$tempCsarId" == "$CSAR_ID" ]
        then
            templateId=$(echo $all_template_response | jq '.['$i'].serviceTemplateId'| sed 's/\"//g')
            break
        fi
    done
fi
#Read creation request from JSON file, prepare curl command
body=$(cat $BODY_FILE_NAME | sed 's/TEMPLATE_ID_PLACEHOLDER/'$templateId'/ig')

#######################################Execute and Get Response###########
response=$(curl -s -X POST -d "$body" -H 'Content-Type: application/json;charset=UTF-8' http://"$MSB_ADDR"/openoapi/sdnonslcm/v1/ns)
nsInstanceId=$(echo $response | jq -c '.nsInstanceId' | sed 's/\"//g')
####return service instance id (needed by instantiation request)
echo $nsInstanceId