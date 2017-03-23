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

# This script is sourced by run-csit.sh after Robot test completion.

#Kill all docker instances
DOKCER_LIST=`docker ps --format "{{.Names}}"`
for docker in $DOCKER_LIST; do
    kill-instance.sh $docker || true
done

#Kill and remove moco simulator
kill  `ps -ax | grep java| grep moco | awk '{print $1}'` || true 
rm -rf moco*.jar || true
