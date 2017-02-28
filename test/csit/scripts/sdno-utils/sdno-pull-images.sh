#!/bin/bash

parameters="$@"

#Lifecycle_Manager
if [[ $parameters == *"Lifecycle_Manager"* ]]
then
    lc_manag=`echo $parameters | sed -e "s/.*Lifecycle_Manager=//g"`
    lc_manag=`echo $lc_manag | sed -e "s/ .*//g"`
    lc_manag="sdno-service-"$lc_manag
else
    lc_manag="sdno-service-lcm"
fi

#Method
if [[ $parameters == *"Method"* ]]
then
    method=`echo $parameters | sed -e "s/.*Method=//g"`
    method=`echo $method | sed -e "s/ .*//g"`
else
    method="simulate-drivers"
fi
    
function pull_docker(){
    #Pull the image from openoint with name $1
    docker pull openoint/"$1"
    return 0
}

#Stop existent docker instances
docker rm -f `docker ps -a | grep -v CONTAINER | awk '{print $1}' `|| true

#Pull MSB
pull_docker common-services-msb

#Pull MSS
pull_docker sdno-service-mss

#Pull BRS
pull_docker sdno-service-brs

#Pull openoint/common-services-extsys
pull_docker common-services-extsys

#Pull openoint/common-services-drivermanager
pull_docker common-services-drivermanager

#Pull openoint/sdno-service-vpc
pull_docker sdno-service-vpc

#Pull openoint/sdnhub-driver-ct-te
pull_docker sdnhub-driver-ct-te

#Pull openoint/sdno-service-ipsec
pull_docker sdno-service-ipsec

#Pull openoint/sdno-service-l2vpn
pull_docker sdno-service-l2vpn

#Pull openoint/sdno-service-l3vpn
pull_docker sdno-service-l3vpn

#Pull openoint/$lc_manag
pull_docker $lc_manag

#Pull openoint/sdno-service-route
pull_docker sdno-service-route

#Pull openoint/sdno-service-servicechain
pull_docker sdno-service-servicechain

#Pull openoint/sdno-service-site
pull_docker sdno-service-site

#Pull openoint/sdno-service-vxlan
pull_docker sdno-service-vxlan

#Pull openoint/sdno-vsitemgr
pull_docker sdno-vsitemgr

if [[ $method == "simulate-drivers" ]]
then
    #Pull openoint/simulate-sdnhub-driver-huawei-l3vpn
    pull_docker simulate-sdnhub-driver-huawei-l3vpn

    #Pull openoint/sdno-driver-simul-sfc
    pull_docker sdno-driver-simul-sfc

    #Pull openoint/simulate-sdnhub-driver-huawei-openstack
    pull_docker simulate-sdnhub-driver-huawei-openstack

    #Pull openoint/simulate-sdnhub-driver-huawei-overlay
    pull_docker simulate-sdnhub-driver-huawei-overlay

    #Pull openoint/simulate-sdnhub-driver-zte-sptn
    pull_docker simulate-sdnhub-driver-zte-sptn
else
    #Pull openoint/sdnhub-driver-huawei-l3vpn
    pull_docker driver-huawei-l3vpn

    #Pull openoint/sdnhub-driver-huawei-servicechain
    pull_docker sdnhub-driver-huawei-servicechain

    #Pull openoint/sdnhub-driver-huawei-openstack
    pull_docker sdnhub-driver-huawei-openstack

    #Pull openoint/sdnhub-driver-huawei-overlay
    pull_docker sdnhub-driver-huawei-overlay

    #Pull openoint/sdnhub-driver-zte-sptn
    pull_docker sdnhub-driver-zte-sptn
fi
