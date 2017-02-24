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

#copy the logs files
docker cp multivim-broker:/service/multivimbroker/logs/runtime*.log ${SCRIPTS}/../../../archives
docker cp multivim-driver-newton:/service/newton/logs/runtime*.log ${SCRIPTS}/../../../archives
docker cp multivim-driver-kilo:/service/kilo/logs/runtime*.log ${SCRIPTS}/../../../archives
#docker cp multivim-driver-vio:/service/vio/logs/runtime*.log ${SCRIPTS}/../../../archives


# This script is sourced by run-csit.sh after Robot test completion.
kill-instance.sh i-msb
#kill-instance.sh i-esr
kill-instance.sh multivim-driver-newton
kill-instance.sh multivim-driver-kilo
#kill-instance.sh multivim-driver-vio
kill-instance.sh multivim-broker
#kill-instance.sh simulator

