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

SDNO_CONTAINERS=(i-sdno-mss i-sdno-brs
            i-sdno-vxlan i-sdno-ipsec i-sdno-route i-sdno-site
            i-sdno-nslcm i-sdno-overlay i-sdno-sfc i-sdno-vpc
            i-sdno-monitor i-sdno-optimize i-sdno-vsite
            i-sdno-l2vpn i-sdno-l3vpn
            )

sdnoloop_i=0
sdnoloop_len=${#SDNO_CONTAINERS[*]}
while [ $sdnoloop_i -lt $sdnoloop_len ]; do
    container=${SDNO_CONTAINERS[$sdnoloop_i]}
    kill-instance.sh $container

    echo "I=$sdnoloop_i; Len=$sdnoloop_len; Container=$container"

    let sdnoloop_i++
done