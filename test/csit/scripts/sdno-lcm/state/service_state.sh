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
[ $# -ne 2 ] && { echo "Usage: $0 <MSB_ADDR[ipv4:port]> <NSINSTANCEID[uuid]>"; exit 1;}

MSB_ADDR=$1
echo $MSB_ADDR
NS_INSTANCE_ID=$2
echo $NS_INSTANCE_ID

response=$(curl -m60 -X GET -H 'Content-Type: application/json;charset=UTF-8' http://"$MSB_ADDR"/openoapi/sdnonslcm/v1/ns/"$NS_INSTANCE_ID")
additionalParamsContent=$(echo $response | jq -c '.additionalParams')
arraySize=$(echo $additionalParamsContent | jq '. | length'-1)
lifecycleState="null"
actionState="null"
for i in $(seq 0 $arraySize);
do
    currentElement=$(echo $additionalParamsContent | jq -c '.['$i']')
    name=$(echo $currentElement | jq '.name' | sed 's/\"//g' | sed -n 's/ *//gp')
    value=$(echo $currentElement | jq '.value' | sed 's/\"//g' | sed -n 's/ *//gp')
    if [ $name == "lifecycleState" ]
    then
        lifecycleState=$value
    fi
    if [ $name == "actionState" ]
    then
        actionState=$value
fi
done
echo "$lifecycleState.$actionState"