#!/usr/bin/env bash
###############################################################################
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
###############################################################################
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo $SCRIPT_DIR

#CHECK IF MSB_ADDR IS GIVEN IN COMMAND
if [ -z "$1" ]
then
   echo "There is no MSB_ADDR"
   echo "USAGE: $0 <MSB_ADDR[ipv4:port]>"
   exit 1
fi
MSB_ADDR=$1
echo $MSB_ADDR

# Wait for MSB initialization
echo Wait for MSB initialization
for i in {1..20}; do
    curl -sS -m 1 $MSB_ADDR > /dev/null && break
    sleep $i
done
#MSB initialized 

#Check if common-tosca-catalog  is registered with MSB or not
curl -sS -X GET http://$MSB_ADDR/api/microservices/v1/services/catalog/version/v1 -H "Accept: application/json" -H "Content-Type: application/json" 
#check if common-tosca-aria is registered with MSB or not 
curl -sS -X GET http://$MSB_ADDR/api/microservices/v1/services/tosca/version/v1 -H "Accept: application/json" -H "Content-Type: application/json"
echo Sending POST request to Catalog
CsarIdString=$(curl -sS -X POST -H "Content-Type: multipart/form-data; boundary=-WebKitFormBoundary7MA4YWxkTrZu0gW" -H "Cache-Control: no-cache" -H "Postman-Token: abcb6497-b225-c592-01be-e9ff460ca188" -F "file=@$SCRIPT_DIR/enterprise2DC.csar" http://$MSB_ADDR/openoapi/catalog/v1/csars)
#getting csarId from the json output
echo $CsarIdString
CsarId=$(echo ${CsarIdString} | jq -c '.csarId'| sed 's/\"//g')
echo ${CsarId}
