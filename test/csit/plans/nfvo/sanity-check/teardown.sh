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
docker cp jujuvnfm:/service/logs/jujuvnfmadapterservice.log ${SCRIPTS}/../../../archives
docker cp resmgr:/service/logs/resmanagement.log ${SCRIPTS}/../../../archives
docker cp hwvnfmdriver:/service/logs/vnfmadapterservice.log ${SCRIPTS}/../../../archives


# This script is sourced by run-csit.sh after Robot test completion.
kill-instance.sh i-msb
kill-instance.sh jujuvnfm
kill-instance.sh resmgr
kill-instance.sh hwvnfmdriver
kill-instance.sh simulator
kill-instance.sh nslcm
kill-instance.sh gvnfmdriver
kill-instance.sh ztevmanagerdriver

