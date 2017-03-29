#!/bin/bash
#
# Copyright 2017 Huawei Technologies Co., Ltd.
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

source ${SCRIPTS}/common_functions.sh

CONTAINERS=(i-sdno-mss i-sdno-brs
            i-sdno-vxlan i-sdno-ipsec i-sdno-route i-sdno-site
            i-sdno-nslcm i-sdno-overlay i-sdno-sfc i-sdno-vpc
            i-sdno-monitor i-sdno-optimize i-sdno-vsite
            i-sdno-l2vpn i-sdno-l3vpn
            )

IMAGES=(sdno-service-mss sdno-service-brs
        sdno-service-vxlan sdno-service-ipsec sdno-service-route sdno-service-site
        sdno-service-nslcm sdno-service-overlayvpn sdno-service-servicechain sdno-service-vpc
        sdno-monitoring sdno-optimize sdno-vsitemgr
        sdno-service-l2vpn sdno-service-l3vpn
        )

NAMES=(MSS BRS
       VxLAN IPSec Route Site
       Nslcm Overlay SFC VPC
       Monitoring Optimizer VSiteMAnager
       L2VPN L3VPN
       )

VALIDATIONS=(sdnomss sdnobrs
             sdnovxlan sdnoipsec sdnoroute sdnolocalsite
             sdnonslcm sdnooverlay sdnoservicechain sdnovpc
             link_flow_monitor mpls-optimizer vsite_mgr
             sdnol2vpn sdnol3vpn
             )

i=0
len=${#CONTAINERS[*]}
while [ $i -lt $len ]; do
    container=${CONTAINERS[$i]}
    image="openoint/${IMAGES[$i]}"
    name=${NAMES[$i]}
    validation=${VALIDATIONS[$i]}

    # Start corresponding docker container
    if  [ "$container" == "i-sdno-nslcm" ]
    then
        run-instance.sh $image $container "-e MSB_ADDR=$1 -e MYSQL_ADDR=$2"
    elif [ "$container" == "i-sdno-monitor" ] || [ "$container" == "i-sdno-optimize" ] || [ "$container" == "i-sdno-vsite" ]
    then
        run-instance.sh $image $container "-e MSB_ADDR=$1 -e CSIT=True"
    else
        run-instance.sh $image $container "-e MSB_ADDR=$1"
    fi

    # Validate that the service has started and registered to MSB.
    curl_path='http://'$1'/openoapi/microservices/v1/services'
    sleep_msg="Waiting_for: "$name
    wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE="$sleep_msg" REPEAT_NUMBER="100" GREP_STRING=$validation

    let i++
done