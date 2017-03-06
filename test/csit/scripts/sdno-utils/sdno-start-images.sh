#!/bin/bash
#Common functions used in other scripts
source ${SCRIPTS}/common_functions.sh

#File containing variables
source $CUR_DIR/variables.sh

#Stop existent docker instances
docker rm -f $(docker ps -a --format={{.Names}}) || true

parameters="$@"

#Parameter method
if [[ $parameters == *"Method"* ]]
then
    method=`echo $parameters | sed -e "s/.*Method=//g"`
    method=`echo $method | sed -e "s/ .*//g"`
else
    method="simulate-drivers"
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
run_docker i-mss sdno-service-mss
curl_path='http://'$MSB_ADDR'/openoapi/microservices/v1/services/'
sleep_msg="Waiting_connection_for_url_for:i-mss"
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' GREP_STRING="sdnomss"  REPEAT_NUMBER="25"

#Start BRS
run_docker i-brs sdno-service-brs
curl_path='http://'$MSB_ADDR'/openoapi/microservices/v1/services/'
sleep_msg="Waiting_connection_for_url_for:i-brs"
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' GREP_STRING="sdnobrs"  REPEAT_NUMBER="25"

#Start openoint/common-services-extsys
run_docker i-common-services-extsys common-services-extsys
sleep_msg="Waiting_for_i-common-services-extsys"
curl_path='http://'${MSB_ADDR}'/openoapi/extsys/v1/vims'
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' GREP_STRING="\[" REPEAT_NUMBER="15"

#Start openoint/common-services-drivermanager
run_docker i-drivermgr common-services-drivermanager
curl_path='http://'${MSB_ADDR}'/openoapi/drivermgr/v1/drivers'
sleep_msg="Waiting_connection_for_url_for: i-drivermgr"
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' GREP_STRING="\[" REPEAT_NUMBER="15"

#Start openoint/sdno-service-vpc
run_docker s-vpc sdno-service-vpc

#Start openoint/sdnhub-driver-ct-te
run_docker d-ct-te sdnhub-driver-ct-te

#Start openoint/sdno-service-ipsec
run_docker s-ipsec sdno-service-ipsec

#Start openoint/sdno-service-l2vpn
run_docker s-l2vpm sdno-service-l2vpn

#Start openoint/sdno-service-l3vpn
run_docker s-l3vpn sdno-service-l3vpn

#Start openoint/lc_manag
run_docker s-$lc_manag $lc_manag

#Start openoint/sdno-service-route
run_docker s-route sdno-service-route

#Start openoint/sdno-service-servicechain
run_docker s-servicechain sdno-service-servicechain

#Start openoint/sdno-service-site
run_docker s-site sdno-service-site

#Start openoint/sdno-service-overlayvpn
run_docker s-overlayvpn openoint/sdno-service-overlayvpn

#Start openoint/sdno-service-vxlan
run_docker s-vxlan sdno-service-vxlan

#Start openoint/sdno-vsitemgr
run_docker s-vsitemgr sdno-vsitemgr

#Start drivers (simulated or real)
temp=0
while [ $temp -le 4 ]
do
    if [[ $method == "simulate-drivers" ]]
    then
        run_docker ${simulated_drivers_docker_name[$temp]} ${simulated_drivers[$temp]}
    else
        run_docker ${drivers_docker_name[$temp]} ${drivers[$temp]}
    fi
    temp=$((temp+1))
done