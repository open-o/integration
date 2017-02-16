#!/bin/bash
#
# Copyright (c) 2017 GigaSpaces Technologies Ltd. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.
#

VNFSDK_BLUEPRINTS_HOME="${SCRIPTS}/../plans/vnf-sdk-design-pkg/sanity-check/yamlinput"
VNFSDK_CSAR_HOME="${SCRIPTS}/../plans/vnf-sdk-design-pkg/sanity-check/csarinput"
VNFSDK_TEMP_DIR="${VIRTUAL_ENV}/vnfsdk"

mkdir -p ${VNFSDK_TEMP_DIR}
cd ${VNFSDK_TEMP_DIR}

git clone https://gerrit.open-o.org/r/vnf-sdk-design-pkg
cd vnf-sdk-design-pkg

pip install -r requirements.txt
pip install . 
pip install robotframework-difflibrary

#Workaround to avoid dependency conflict in runtime:
#pkg_resources.ContextualVersionConflict: (requests 2.13.0 (/tmp/tmp.Jnagi6MHTlrobot_venv/lib/python2.7/site-packages), Requirement.parse('requests==2.11.1'), set(['aria']))
pip uninstall requests -y
pip install requests==2.11.1

ROBOT_VARIABLES="-v SCRIPTS:${SCRIPTS} -v VNFSDK_BLUEPRINTS_HOME:${VNFSDK_BLUEPRINTS_HOME} -v VNFSDK_CSAR_HOME:${VNFSDK_CSAR_HOME} -v VNFSDK_TEMP_DIR:${VNFSDK_TEMP_DIR}"

