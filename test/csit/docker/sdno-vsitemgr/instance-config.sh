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
sed -i "s|SDNO_SDNO_VSITEMGR_ADDRESS=.*:|SDNO_SDNO_VSITEMGR_ADDRESS=\"$SERVICE_IP:|" run.sh
sed -i "s|MSB_ADDRESS=.*|MSB_ADDRESS=$MSB_ADDR|" run.sh
cat run.sh
