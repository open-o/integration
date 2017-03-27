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

source ./variables.sh

MOCO_JAR="moco-runner-0.11.0-standalone.jar"
MSB_SERVICES_URL="/openoapi/microservices/v1/services"

#Get the ip of the started docker image
CREATED_SERVICE_IP=`ifconfig  eth0| grep "inet " | awk '{print $2}'`

index=0
array_size=${#SERVICE_NAME[*]}
while [ $index -ne $array_size ]; do
    PROJECT_NAME=${SERVICE_NAME[$index]}
    MSB_REG_JSON="msbRegistration.json"
    MICROSERVICE_LISTEN_PORT=${SERVICE_PORT[$index]}
    SERVICE_TYPE="http"

    cd $PROJECT_NAME
    JSON_COMPLETE=`ls *moco-config.json`
    SERVICE_IP[$index]=$CREATED_SERVICE_IP
    sed -i 's/SERVICE_IP/'$CREATED_SERVICE_IP'/g' msbRegistration.json

    #Register to MSB services
    curl -d @$MSB_REG_JSON -H "Content-Type: application/json;charset=UTF-8" http://$MSB_ADDR$MSB_SERVICES_URL
    #Start Moco
    java -jar ../$MOCO_JAR $SERVICE_TYPE -p $MICROSERVICE_LISTEN_PORT  -c  $JSON_COMPLETE | tee -a /service/log/moco.log &

    cd ..
    index=$((index + 1))
done

tail -F /service/log/moco.log