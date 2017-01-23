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

# proxy connection to MSB
nohup socat TCP-LISTEN:8080,fork TCP:$MSB_ADDR  </dev/null >/dev/null 2>&1 &

# ensure mysql launched wherther first-run or not
su mysql -c "nohup /usr/bin/mysqld_safe </dev/null >/dev/null 2>&1 &"

# Start microservice
cd bin
./start.sh

# tail -F not work on remote-fs(BTRFS/AUFS)
while [ ! -e /service/logs/application.log ]; do
    sleep 1
done
# keep shell running to prevent container from exit
tail -f /service/logs/application.log
