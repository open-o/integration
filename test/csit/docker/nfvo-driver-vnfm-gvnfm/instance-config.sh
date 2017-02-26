#!/bin/bash
#
# Copyright 2017 ZTE Corporation.
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
# Configure MSB IP address
MSB_IP=`echo $MSB_ADDR | cut -d: -f 1`
MSB_PORT=`echo $MSB_ADDR | cut -d: -f 2`

sed -i "s|MSB_SERVICE_IP.*|MSB_SERVICE_IP = '$MSB_IP'|" nfvo/drivers/vnfm/gvnfm/gvnfmadapter/driver/pub/config/config.py
sed -i "s|MSB_SERVICE_PORT.*|MSB_SERVICE_PORT = '$MSB_PORT'|" nfvo/drivers/vnfm/gvnfm/gvnfmadapter/driver/pub/config/config.py
sed -i "s|\"ip\": \".*\"|\"ip\": \"$SERVICE_IP\"|" nfvo/drivers/vnfm/gvnfm/gvnfmadapter/driver/pub/config/config.py
cat GVNFM_DRIVER_CONFIG_PATH/config.py

sed -i "s|127\.0\.0\.1|$SERVICE_IP|" nfvo/drivers/vnfm/gvnfm/gvnfmadapter/run.sh
sed -i "s|127\.0\.0\.1|$SERVICE_IP|" nfvo/drivers/vnfm/gvnfm/gvnfmadapter/stop.sh
