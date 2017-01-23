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

# Configure keystone
ADMIN_TOKEN=$OS_SERVICE_TOKEN
KEYSTONE_PORT=5000

sed -i "s|IP=.*|IP=127.0.0.1|" webapps/ROOT/WEB-INF/classes/auth_service.properties
sed -i "s|PORT=.*|PORT=$KEYSTONE_PORT|" webapps/ROOT/WEB-INF/classes/auth_service.properties
cat webapps/ROOT/WEB-INF/classes/auth_service.properties

sed -i "s|admin_token=.*|admin_token=$ADMIN_TOKEN|" webapps/ROOT/WEB-INF/classes/keystone_config.properties
cat webapps/ROOT/WEB-INF/classes/keystone_config.properties

sed -i "s|#admin_token.*|admin_token=$ADMIN_TOKEN|" /etc/keystone/keystone.conf
sed -i "s|#public_port.*|public_port=$KEYSTONE_PORT|" /etc/keystone/keystone.conf
sed -i "s|#verbose.*|verbose=true|" /etc/keystone/keystone.conf
cat /etc/keystone/keystone.conf | egrep -v '^[[:space:]]*$|^ *#'
