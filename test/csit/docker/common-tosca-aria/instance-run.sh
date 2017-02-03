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
# Run microservice
MSB_IP=`echo $MSB_ADDR | cut -d: -f1`
MSB_PORT=`echo $MSB_ADDR | cut -d: -s -f2`

source env/bin/activate

if [ -z "$MSB_PORT" ]
then
	aria-openo --rundir log --ip $SERVICE_IP --msb_ip $MSB_IP start
else
	aria-openo --rundir log --ip $SERVICE_IP --msb_ip $MSB_IP --msb_port $MSB_PORT start
fi

tail -F log/aria-openo.log
