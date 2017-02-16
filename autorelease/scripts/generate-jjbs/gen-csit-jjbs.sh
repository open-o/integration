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

# csit plans root dir
ROOT=`git rev-parse --show-toplevel`/autorelease

BUILD_DIR=$ROOT/build
JJB_DIR=$BUILD_DIR/ci-management/jjb

PLANS_DIR=`git rev-parse --show-toplevel`/test/csit/plans

source $ROOT/scripts/generate-jjbs/workarounds.sh


find $PLANS_DIR -mindepth 1 -maxdepth 1 -type d -printf "%f\n" | sort | while read repo; do
    cat > $JJB_DIR/$repo/${repo}-csit.yaml <<EOF
---
- project:
    name: ${repo}-csit
    jobs:
      - 'integration-verify-{project}-csit-{functionality}'
      - '{project}-csit-{functionality}':
          trigger_jobs:
EOF

    has_subprojects=0
    for r in "${SPLIT_REPOS[@]}"; do
	if [ "$repo" = "$r" ]; then
	    has_subprojects=1
	fi
    done

    if [ $has_subprojects -eq 1 ]; then
	poms=`find $BUILD_DIR/$repo -mindepth 1 -type d -exec test -e "{}/pom.xml" ';' -prune -printf "%P/pom.xml\n" | sort`
    else
	poms=`find $BUILD_DIR/$repo -type d -exec test -e "{}/pom.xml" ';' -prune -printf "%P/pom.xml\n" | sort`
	if [ "$poms" != "/pom.xml" ]; then
	    has_subprojects=1
	fi
    fi

    if [ $has_subprojects -eq 0 ]; then
	# root pom.xml found
	cat >> $JJB_DIR/$repo/${repo}-csit.yaml <<EOF
            - '${repo}-master-merge-java'
EOF
    elif [ ! -z "$poms" ]; then
	for pom in $poms; do
	    pompath=${pom%/pom.xml}
	    subproject=${pompath////-} # replace slash with dash	
	    cat >> $JJB_DIR/$repo/${repo}-csit.yaml <<EOF
            - '${repo}-master-${subproject}-merge-java'
EOF
	done
    fi
    
	cat >> $JJB_DIR/$repo/${repo}-csit.yaml <<EOF

    project: '${repo}'
    functionality:
EOF
    find $PLANS_DIR/$repo -mindepth 1 -maxdepth 1 -type d -printf "%f\n" | sort | while read func; do
	echo $repo / $func
	
	cat >> $JJB_DIR/$repo/${repo}-csit.yaml <<EOF
      - '${func}'
EOF
    done
	    
    cat >> $JJB_DIR/$repo/${repo}-csit.yaml <<EOF
    robot-options: ''

    branch: 'master'
EOF
done
