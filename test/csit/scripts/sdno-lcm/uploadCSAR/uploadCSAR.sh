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
#CHECK IF MSB_ADDR and SCRIPT DIR are given in command
[ $# -lt 2 ] || [ $# -gt 3 ] && { echo "Usage: $0 <MSB_ADDR[ipv4:port]> <CSAR_DIR> <CSAR_FILENAME:default[enterprise2DC.csar]>"; exit 1;}

MSB_ADDR=$1
echo $MSB_ADDR
CSAR_DIR=$2
echo $CSAR_DIR

#CHECK IF CSAR filename IS GIVEN IN COMMAND. "enterprise2SC.csar" is the default value to avoid breaking exist scripts.
if [ -z "$3" ]
then
     CSAR_FILENAME="$CSAR_DIR/enterprise2DC.csar"
else
   CSAR_FILENAME="$CSAR_DIR/$3"
fi
if [ -e $CSAR_FILENAME ]
then 
    echo "$CSAR_FILENAME found and it is a file ..."
else
    echo "$CSAR_FILENAME is not a file ...."
    echo "Usage: $0 <MSB_ADDR[ipv4:port]> <CSAR_SCRIPT_DIR> <CSAR_FILENAME:default[enterprise2DC.csar]> "
    exit 1
fi

echo "Sending POST request to Catalog"
CsarIdString=$(curl -sS -m60 -X POST -H "Content-Type: multipart/form-data; boundary=-WebKitFormBoundary7MA4YWxkTrZu0gW" -H "Cache-Control: no-cache" -H "Postman-Token: abcb6497-b225-c592-01be-e9ff460ca188" -F "file=@$CSAR_FILENAME" http://$MSB_ADDR/openoapi/catalog/v1/csars)
#getting csarId from the json output
echo $CsarIdString
CsarId=$(echo ${CsarIdString} | jq -c '.csarId'| sed 's/\"//g')
echo ${CsarId}