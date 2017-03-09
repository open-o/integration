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
MOCO_JAR="moco-runner-0.11.0-standalone.jar"
DRIVERMANAGER_URL="/openoapi/drivermgr/v1/drivers"

SFC_TEMPLATE_FILE="template-sfc-driver.json"
SFC_SIMU_FILE="sfc_sim_file.json"
SFC_DRIVER_SIMU_FILENAME="sdnhub-driver-huawei-servicechain.json"

SERVICE_TYPE="http"
DRIVER_LISTEN_PORT="8542";
DRIVER_SHUTDOWN_PORT="18542";
LOG_FILENAME="./logs/moco.log"

mkdir -p logs

DRIVER_IP=`ifconfig  eth0| grep "inet " | awk '{print $2}'`
cat $SFC_TEMPLATE_FILE | sed -e 's/DRIVER_IP/$DRIVER_IP/g' > $SFC_SIMU_FILE

#Register SFC Driver to Driver Manager
curl -d @$SFC_SIMU_FILE -H "Content-Type: application/json;charset=UTF-8" http://$MSB_ADDR$DRIVERMANAGER_URL

#Start the simulated driver for SFC
java -jar $MOCO_JAR $SERVICE_TYPE -p $DRIVER_LISTEN_PORT  -s $DRIVER_SHUTDOWN_PORT -c  $SFC_DRIVER_SIMU_FILENAME | tee -a $LOG_FILENAME
tail $LOG_FILENAME
