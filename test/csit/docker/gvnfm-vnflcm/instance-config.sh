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

sed -i "s|MSB_SERVICE_IP.*|MSB_SERVICE_IP = '$MSB_IP'|" gvnfm-vnflcm/lcm/lcm/pub/config/config.py
sed -i "s|MSB_SERVICE_PORT.*|MSB_SERVICE_PORT = '$MSB_PORT'|" gvnfm-vnflcm/lcm/lcm/pub/config/config.py
sed -i "s|DB_NAME.*|DB_NAME = 'gvnfm'|" gvnfm-vnflcm/lcm/lcm/pub/config/config.py
sed -i "s|DB_USER.*|DB_USER = 'gvnfm'|" gvnfm-vnflcm/lcm/lcm/pub/config/config.py
sed -i "s|DB_PASSWD.*|DB_PASSWD = 'gvnfm'|" gvnfm-vnflcm/lcm/lcm/pub/config/config.py
sed -i "s|\"ip\": \".*\"|\"ip\": \"$SERVICE_IP\"|" gvnfm-vnflcm/lcm/lcm/pub/config/config.py

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
sed -i "s|DB_IP.*|DB_IP = '$MYSQL_IP'|" gvnfm-vnflcm/lcm/lcm/pub/config/config.py
sed -i "s|DB_PORT.*|DB_PORT = $MYSQL_PORT|" gvnfm-vnflcm/lcm/lcm/pub/config/config.py

cat gvnfm-vnflcm/lcm/lcm/pub/config/config.py

sed -i "s|127\.0\.0\.1|$SERVICE_IP|" gvnfm-vnflcm/lcm/run.sh
sed -i "s|127\.0\.0\.1|$SERVICE_IP|" gvnfm-vnflcm/lcm/stop.sh
