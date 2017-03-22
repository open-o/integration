#!/bin/bash
function helpMe(){
    echo "USAGE: $0 <OPTIONS>"
    echo "OPTIONS"
    echo "     Method = {simulate-network-services, simulate-drivers, real-drivers} - default value simulate-network-services"
    echo "     Lifecycle_Manager = {lcm, nslcm} - default value lcm"
    echo "     --help: display this help"
}

function displayMessage(){
    echo "******************************************************"
    echo "**** PULL IMAGES STEPS *******************************"
    if [[ $1 == "simulate-network-services" ]]
    then
      echo "************** SIMULATE-NETWORK-SERVICE **************"
    elif [[ $1 == "simulate-drivers" ]]
    then
      echo "****************** SIMULATE-DRIVERS ******************"
    elif [[ $1 == "real-drivers" ]]
    then
        echo "******************** REAL-DRIVERS ********************"
    elif [[ $1 == "sdno-service-lcm" ]]
    then
        echo "*************** LIFE-CYCLE-MANAGER LCM ***************"
    elif [[ $1 == "sdno-service-nslcm" ]]
    then
        echo "****** NETWORK-SERVICE-LIFE-CYCLE-MANAGER NSLCM  *****"
    fi
    echo "******************************************************"
}
parameters="$@"
#display help
if [[ $parameters == *"--help"* ]]
then
    helpMe
    exit 0
fi

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
    method="simulate-network-services"
fi

function pull_docker(){
    #Pull the image from openoint with name $1
    docker pull openoint/"$1"
    return 0
}

#Stop existing docker instances if there is any
if [[ ! -z "$DOCKER_INSTANCES_ID" ]]
then
    echo "Docker list: $DOCKER_INSTANCES_ID"
    docker rm -f $DOCKER_INSTANCES_ID
fi

#Pull MSB
pull_docker common-services-msb

#Pull MSS
pull_docker sdno-service-mss

#Pull BRS
pull_docker sdno-service-brs

#Common TOSCA: Catalog
pull_docker common-tosca-catalog

#Common TOSCA: Tosca
pull_docker common-tosca-aria

#Common TOSCA: Tosca-inventory
pull_docker common-tosca-inventory

#Pull openoint/$lc_manag
displayMessage $lc_manag
pull_docker $lc_manag

if [[ $method == "simulate-network-services" ]]
then
    #SNDO Service simulator
    displayMessage simulate-network-services
    pull_docker simulate-sdno-services
else
    #Pull openoint/common-services-extsys
    pull_docker common-services-extsys

    #Pull openoint/common-services-drivermanager
    pull_docker common-services-drivermanager

    #Pull openoint/sdno-service-vpc
    pull_docker sdno-service-vpc

    #Pull openoint/sdno-service-overlayvpn
    pull_docker sdno-service-overlayvpn

    #Pull openoint/sdno-service-ipsec
    pull_docker sdno-service-ipsec

    #Pull openoint/sdno-service-l2vpn
    pull_docker sdno-service-l2vpn

    #Pull openoint/sdno-service-l3vpn
    pull_docker sdno-service-l3vpn

    #Pull openoint/sdno-service-route
    pull_docker sdno-service-route

    #Pull openoint/sdno-service-servicechain
    pull_docker sdno-service-servicechain

    #Pull openoint/sdno-service-site
    pull_docker sdno-service-site

    #Pull openoint/sdno-service-vxlan
    pull_docker sdno-service-vxlan

    if [[ $method == "simulate-drivers" ]]
    then
        displayMessage simulate-drivers
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
        displayMessage real-drivers
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
fi