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

CONTAINERS=(i-sdnhub-ct-te i-sdnhub-zte-sptn
            i-sdnhub-hw-l3vpn i-sdnhub-hw-openstack
            i-sdnhub-hw-overlay i-sdnhub-hw-sfc
            )

IMAGES=(sdnhub-driver-ct-te sdnhub-driver-zte-sptn
        sdnhub-driver-huawei-l3vpn sdnhub-driver-huawei-openstack
        sdnhub-driver-huawei-overlay sdnhub-driver-huawei-servicechain
        )

NAMES=(CT-TE-Driver ZTE-SPTN-Driver
       HW-L3VPN-Driver HW-Openstack-Driver
       HW-Overlay-Driver HW-SFC-Driver
       )

VALIDATIONS=(sdnhub-driver-ct-te sdno-zte-sptn-driver-1
             sdnhubl3vpndriver-0-1 sdnhubopenstackdriver-0-1
             sdnhuboverlaydriver-0-1 sdnhubservicechaindriver-0-1
             )


i=0
len=${#CONTAINERS[*]}
while [ $i -lt $len ]; do
    container=${CONTAINERS[$i]}
    image="openoint/${IMAGES[$i]}"
    name=${NAMES[$i]}
    validation=${VALIDATIONS[$i]}

    # Start corresponding docker container
    if  [ "$container" == "i-sdnhub-ct-te" ]
    then
        run-instance.sh $image $container "-e MSB_ADDR=$1 -e CSIT=True"
    else
        run-instance.sh $image $container "-e MSB_ADDR=$1"
    fi

    # Validate that the driver has started and registered to Driver Manager.
    curl_path='http://'$1'/openoapi/drivermgr/v1/drivers'
    sleep_msg="Waiting_for: "$name
    wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE="$sleep_msg" REPEAT_NUMBER="100" GREP_STRING=$validation

    let i++
done