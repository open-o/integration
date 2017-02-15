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

# autorelease root dir
ROOT=`git rev-parse --show-toplevel`/autorelease

BUILD_DIR=$ROOT/build
JJB_DIR=$BUILD_DIR/ci-management/jjb

cd $BUILD_DIR

# docker root dir
ROOT=`git rev-parse --show-toplevel`/test/csit/docker

cd $ROOT

cat > $JJB_DIR/integration/integration-docker-microservices.yaml <<EOF
---
- project:
    name: integration-docker-microservices
    project: 'integration'
    branch: 'master'
    version: '1.1.0-SNAPSHOT'
    mvn-settings: 'autorelease-settings'
    build-node: 'centos7-robot-8c-8g'
    jobs:
      - 'integration-{microservice}-verify-docker'
      - 'integration-{microservice}-merge-docker'
    microservice:
EOF

for microservice in `$ROOT/scripts/ls-microservices.py | sort`; do
    cat >> $JJB_DIR/integration/integration-docker-microservices.yaml <<EOF
      - '${microservice}'
EOF
done
