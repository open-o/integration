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
# Configure webapp deployment
if [ ! -e webapps/openoui ]; then
    unzip -q -u openo-portal.war -d webapps/openoui
fi

MSB_IP=`echo $MSB_ADDR | cut -d: -f 1`
MSB_PORT=`echo $MSB_ADDR | cut -d: -f 2`

sed -i "s|<hostIp>.*</hostIp>|<hostIp>http://$MSB_IP</hostIp>|g" webapps/openoui/WEB-INF/classes/portalConfig/msb_register.xml
sed -i "s|<hostPort>.*</hostPort>|<hostPort>$MSB_PORT</hostPort>|g" webapps/openoui/WEB-INF/classes/portalConfig/msb_register.xml
sed -i "s|<ip>.*</ip>|<ip>$SERVICE_IP</ip>|g" webapps/openoui/WEB-INF/classes/portalConfig/msb_register.xml
cat webapps/openoui/WEB-INF/classes/portalConfig/msb_register.xml
