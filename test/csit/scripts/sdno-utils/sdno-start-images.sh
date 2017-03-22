#!/bin/bash
#NB: This script is designed to be executed in automation
# environment. In order to run this test locally
# you need to replace the ${SCRIPTS} by the local value.
function helpMe(){
    echo "USAGE: $0 <OPTIONS>"
    echo "OPTIONS"
    echo "     Method = {simulate-network-services, simulate-drivers, real-drivers} - default value simulate-network-services"
    echo "     Lifecycle_Manager = {lcm, nslcm} - default value lcm"
    echo "     Start_wait = { Integer: number of seconds } - default value 0"
    echo "     --help: display this help"
}

function displayMessage(){
    echo "******************************************************"
    echo "**** START IMAGES STEPS ******************************"
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

#Common functions used in other scripts
source ${SCRIPTS}/common_functions.sh

#File containing variables
source ${SCRIPTS}/sdno-utils/variables.sh

#List all running docker instance
DOCKER_INSTANCES_NAME=`docker ps -a --format={{.Names}}`

#Stop existing docker instances if there is any
if [[ ! -z "$DOCKER_INSTANCES_NAME" ]]
then
    echo "Docker list: $DOCKER_INSTANCES_NAME"
    docker rm -f $DOCKER_INSTANCES_NAME
fi

parameters="$@"
#display help
if [[ $parameters == *"--help"* ]]
then
    helpMe
    exit 0
fi

#Parameter method
if [[ $parameters == *"Method"* ]]
then
    method=`echo $parameters | sed -e "s/.*Method=//g"`
    method=`echo $method | sed -e "s/ .*//g"`
else
    method="simulate-network-services"
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

#Wait
if [[ $parameters == *"Start_wait"* ]]
then
    wait=`echo $parameters | sed -e "s/.*Start_wait=//g"`
    wait=`echo $wait | sed -e "s/ .*//g"`
else
    wait="0"
fi

function run_docker(){
    #$1 docker image_name $1
    #$2 Docker name
    #$3 Sleep time
    if [[ $2 == *"common-services-msb"* ]]
    then
        docker run -d -i -t --name $1 -p 80:$MSB_PORT openoint/$2
    else
        docker run -d -i -t --name $1 -e MSB_ADDR=$MSB_ADDR openoint/$2
    fi
    #sleep sleep_time in seconds
    sleep $wait
}

#Start MSB
MSB_PORT="80"
run_docker i-msb common-services-msb
MSB_ADDR=`docker inspect --format '{{ .NetworkSettings.IPAddress }}' i-msb`:$MSB_PORT
sleep_msg="Waiting_connection_for_url_for:i-msb"
curl_path='http://'${MSB_ADDR}'/openoui/microservices/index.html'
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' GREP_STRING="org_openo_msb_route_title" REPEAT_NUMBER="15"

#Start MSS
echo "Start MSS"
run_docker i-mss sdno-service-mss
curl_path='http://'$MSB_ADDR'/openoapi/microservices/v1/services/sdnomss/version/v1'
sleep_msg="Waiting_connection_for_url_for:i-mss"
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' GREP_STRING="microservice not found" REPEAT_NUMBER="30" MAX_TIME="60" STATUS_CODE="200" EXCLUDE_STRING

#Start BRS
echo "Start BRS"
run_docker i-brs sdno-service-brs
curl_path='http://'$MSB_ADDR'/openoapi/microservices/v1/services/sdnobrs/version/v1'
sleep_msg="Waiting_connection_for_url_for: i-brs"
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' GREP_STRING="microservice not found" REPEAT_NUMBER="50" MAX_TIME="60" STATUS_CODE="200" EXCLUDE_STRING

#Start openoint/lc_manag
displayMessage $lc_manag
run_docker s-$lc_manag $lc_manag
curl_path='http://'$MSB_ADDR'/openoapi/sdnonslcm/v1/swagger.json'
sleep_msg="Waiting_connection_for_url_for: s-$lc_manag"
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE="$sleep_msg" REPEAT_NUMBER="15" STATUS_CODE="200"

#Start openoint/catalog
run_docker i-catalog common-tosca-catalog

#Start openoint/tosca
run_docker i-tosca common-tosca-aria

#Start openoint/tosca-inventory
run_docker i-tosca-inventory common-tosca-inventory

if [[ $method == "simulate-network-services" ]]
then
    #Start Service simulator
    displayMessage simulate-network-services
    run_docker s-simulate-sdno-services simulate-sdno-services
else
    #Start openoint/common-services-extsys
    echo "Start openoint/common-services-extsys"
    run_docker i-common-services-extsys common-services-extsys
    sleep_msg="Waiting_for_i-common-services-extsys"
    curl_path='http://'${MSB_ADDR}'/openoapi/microservices/v1/services/extsys/version/v1'
    wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' GREP_STRING="microservice not found" REPEAT_NUMBER="50" MAX_TIME="60" STATUS_CODE="200" EXCLUDE_STRING

    #Start openoint/common-services-drivermanager
    run_docker i-drivermgr common-services-drivermanager
    curl_path='http://'${MSB_ADDR}'/openoapi/drivermgr/v1/drivers'
    sleep_msg="Waiting_connection_for_url_for: i-drivermgr"
    wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' GREP_STRING="\[" REPEAT_NUMBER="15"

    #Start openoint/sdno-service-vpc
    run_docker s-vpc sdno-service-vpc

    #Start openoint/sdno-service-overlayvpn
    run_docker s-overlayvpn sdno-service-overlayvpn

    #Start openoint/sdno-service-ipsec
    run_docker s-ipsec sdno-service-ipsec

    #Start openoint/sdno-service-l2vpn
    run_docker s-l2vpm sdno-service-l2vpn

    #Start openoint/sdno-service-l3vpn
    run_docker s-l3vpn sdno-service-l3vpn

    #Start openoint/sdno-service-route
    run_docker s-route sdno-service-route

    #Start openoint/sdno-service-servicechain
    run_docker s-servicechain sdno-service-servicechain

    #Start openoint/sdno-service-site
    run_docker s-site sdno-service-site

    #Start openoint/sdno-service-vxlan
    run_docker s-vxlan sdno-service-vxlan

    #Start drivers (simulated or real)
    temp=0
    while [ $temp -le 4 ]
    do
        if [[ $method == "simulate-drivers" ]]
        then
            displayMessage simulate-drivers
            run_docker ${simulated_drivers_docker_name[$temp]} ${simulated_drivers[$temp]}
        else
            displayMessage real-drivers
            run_docker ${drivers_docker_name[$temp]} ${drivers[$temp]}
        fi
        temp=$((temp+1))
    done
fi