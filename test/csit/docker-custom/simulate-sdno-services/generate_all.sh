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
#Configure individually the registration json file
#Create a single json from the list of json files listed in *-moco-config-json-files.lst

source ./variables.sh

index=0
cd /service
for service_folder in `ls -d sdno*/ | cut -f1 -d'/'`
do
    cd $service_folder
    cat ../msbRegistration_general.json | sed -e 's/SERVICE_NAME/'${SERVICE_NAME[$index]}'/g' | sed -e 's/SERVICE_PORT/'${SERVICE_PORT[$index]}'/g' | sed -e 's/SERVICE_PATH/'${SERVICE_PATH[$index]}'/g'  > msbRegistration.json
    cd ..
    index=$((index + 1))
done