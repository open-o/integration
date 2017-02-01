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
# Start service
mv moco-runner-0.11.0-standalone.jar  /var/lib/moco/. 
cd /var/lib/moco

java -jar moco-runner-0.11.0-standalone.jar http -p 18009 -g /var/lib/moco/main.json &

java -jar moco-runner-0.11.0-standalone.jar https -p 18008 -g /var/lib/moco/main.json -https cert.jks -cert mocohttps --keystore mocohttps &
