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

PACKAGE_DETAIL_FILE=$1
echo $PACKAGE_DETAIL_FILE

if [[ -z "${PACKAGE_DETAIL_FILE// }" ]]; then
       echo "error:Please provide input json file"
       echo "Usage: ./deploy-service.sh package-sdnosvc.json"
       exit
fi

# Install jq package which is required to parse json file
export DEBIAN_FRONTEND=noninteractive
apt-get -y install jq

BUS_ADDR=$( cat $PACKAGE_DETAIL_FILE | jq -r '.msbAddr' )
SERVICES=$( cat $PACKAGE_DETAIL_FILE | jq -r '.services' )

SERVIP=$( cat $PACKAGE_DETAIL_FILE | jq -r '.serviceip' )
SERVIP=$( echo "$SERVIP" | tr -d '"' )
echo $SERVIP

if [[ -z "${BUS_ADDR// }" ]]; then
       echo "error:Please configure MSB address:port in the $PACKAGE_DETAIL_FILE file. Ex: msbAddr:192.168.4.39:80"
       exit
fi

iterator=0
arraySize=$( echo $SERVICES | jq length )

# Read port and service name and pull and then run  the docker command
while [ "$iterator" -lt $arraySize ]
do
    
    servicename=$( cat $PACKAGE_DETAIL_FILE |  jq ".services[$iterator].name" )
    port=$( cat $PACKAGE_DETAIL_FILE |  jq ".services[$iterator].portMap" )

    servicename=$( echo "$servicename" | tr -d '"' )
    port=$( echo "$port" | tr -d '"' )


    echo "===Servicename:"$servicename "===PortMapping:"$port

    echo "======= Pulling & Running Docker File ======="
    docker pull openoint/$servicename

    ARG=""
    
    if [[ ! -z "${SERVIP// }" ]]; then
       ARG="$ARG -e SERVICE_IP=$SERVIP"
    fi

    if [[ ! -z "${port// }" ]]; then
       ARG="$ARG -p $port"
    fi

    if [[ -z "${ARG// }" ]]; then
       docker run -d -i -t -e MSB_ADDR=$BUS_ADDR  openoint/$servicename
    else
       docker run -d -i -t -e MSB_ADDR=$BUS_ADDR $ARG openoint/$servicename
    fi

    iterator=`expr $iterator + 1 `

done


