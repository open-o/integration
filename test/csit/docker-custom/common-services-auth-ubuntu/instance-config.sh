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
# Set MSB address
sed -i "s|msb\.address=.*|msb.address=$MSB_ADDR|" etc/microservice.ini
cat etc/microservice.ini

sed -i "s|10\.229\.47\.199|$SERVICE_IP|" etc/microservice/auth_rest.json
cat etc/microservice/auth_rest.json

