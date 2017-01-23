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
# workaround to specific IP of model designer
if [ -z "$MODEL_DESIGNER_IP" ]; then
    export MODEL_DESIGNER_IP=`hostname -i`
fi
echo "MODEL_DESIGNER_IP=$MODEL_DESIGNER_IP"
sed -i "35s/127\.0\.0\.1/$MODEL_DESIGNER_IP/" apiroute/ext/initServices/msb.json
sed -i "47s/127\.0\.0\.1/$MODEL_DESIGNER_IP/" apiroute/ext/initServices/msb.json
cat apiroute/ext/initServices/msb.json
