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
# Initialize DB schema
MSB_IP=`echo $MSB_ADDR | cut -d: -f 1`
sed -i "s|msb\.openo\.org|${MSB_IP}|" etc/conf/restclient.json
cat etc/conf/restclient.json

# Set self IP
sed -i "s|getInputIP|$SERVICE_IP|" etc/register/service.json
cat etc/register/service.json

# Configure MYSQL
if [ -z "$MYSQL_ADDR" ]; then
    export MYSQL_IP=`hostname -i`
    export MYSQL_PORT=3306
    export MYSQL_ADDR=$MYSQL_IP:$MYSQL_PORT
else
    MYSQL_IP=`echo $MYSQL_ADDR | cut -d: -f 1`
    MYSQL_PORT=`echo $MYSQL_ADDR | cut -d: -f 2`
fi
echo "MYSQL_ADDR=$MYSQL_ADDR"
sed -i "/bean id=\"inventory\"/,/bean/ s|jdbc:mysql://[^/]*/|jdbc:mysql://$MYSQL_ADDR/|" webapps/ROOT/WEB-INF/classes/spring/service.xml
sed -i "/bean id=\"inventory\"/,/bean/ s|property name=\"user\".*/>|property name=\"user\" value=\"inventory\" />|" webapps/ROOT/WEB-INF/classes/spring/service.xml
sed -i "/bean id=\"inventory\"/,/bean/ s|property name=\"password\".*/>|property name=\"password\" value=\"inventory\" />|" webapps/ROOT/WEB-INF/classes/spring/service.xml
cat webapps/ROOT/WEB-INF/classes/spring/service.xml
