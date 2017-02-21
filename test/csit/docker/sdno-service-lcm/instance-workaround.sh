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

# workaround for tomcat blocked by VM always short of entropy
sed -i '/#!\/bin\/bash/a export JAVA_OPTS="$JAVA_OPTS -Djava.security.egd=file:/dev/./urandom"' /service/bin/start.sh

# code stick to 127.0.0.1:8080, socat proxy it to actual MSB
sed -i 's/"msb.openo.org"/"127.0.0.1"/g;s/"port":"80"/"port":"8080"/g' /service/etc/conf/restclient.json

# assignn the ip provided from command line while running docker to SDNO_LCM_IP environment variable
export SDNO_LCM_IP=$SERVICE_IP

# done
