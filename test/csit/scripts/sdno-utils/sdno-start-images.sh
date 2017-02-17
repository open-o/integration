#!/bin/bash

#Common functions used in other scripts
source ../common_functions.sh

#Stop existent docker instances
docker rm -f `docker ps -a | grep -v CONTAINER | awk '{print $1}' `|| true

#Start MSB
docker run -d -i -t --name i-msb openoint/common-services-msb
MSB_IP=`docker inspect --format '{{ .NetworkSettings.IPAddress }}' i-msb`:80
MSB_ADDR=`docker inspect --format '{{ .NetworkSettings.IPAddress }}' i-msb`:80
sleep_msg="Waiting_connection_for_url_for:i-msb"
curl_path='http://'${MSB_ADDR}'/openoui/microservices/index.html'
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' GREP_STRING="org_openo_msb_route_title" REPEAT_NUMBER="15"

#Start MSS
docker run --name i-mss -i -t -e MSB_ADDR=$MSB_ADDR -d openoint/sdno-service-mss
curl_path='http://'$MSB_ADDR'/openoapi/microservices/v1/services/'
sleep_msg="Waiting_connection_for_url_for:i-mss"
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' GREP_STRING="sdnomss"  REPEAT_NUMBER="25"

#Start BRS
docker run -d -i -t --name i-brs -e MSB_ADDR=$MSB_ADDR openoint/sdno-service-brs
curl_path='http://'$MSB_ADDR'/openoapi/microservices/v1/services/'
sleep_msg="Waiting_connection_for_url_for:i-brs"
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' GREP_STRING="sdnobrs"  REPEAT_NUMBER="25"

#Start openoint/common-services-extsys
docker run -d -i -t --name i-common-services-extsys -e MSB_ADDR=$MSB_ADDR openoint/common-services-extsys
sleep_msg="Waiting_for_i-common-services-extsys"
curl_path='http://'${MSB_ADDR}'/openoapi/extsys/v1/vims'
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' REPEAT_NUMBER=25 GREP_STRING="\["


#Start openoint/common-services-drivermanager
docker run -d -i -t --name i-drivermgr -e MSB_ADDR=$MSB_ADDR openoint/common-services-drivermanager
curl_path='http://'${MSB_ADDR}'/openoapi/drivermgr/v1/drivers'
sleep_msg="Waiting_connection_for_url_for:"$1
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' GREP_STRING="\[" REPEAT_NUMBER="25" 
sleep 5

#Start openoint/sdno-driver-simul-l2vpn
docker run -d -i -t --name d-l2vpn -e MSB_ADDR=$MSB_ADDR openoint/sdno-driver-simul-l2vpn
sleep 5

#Start openoint/sdno-driver-simul-l3vpn
docker run -d -i -t --name d-l3vpn -e MSB_ADDR=$MSB_ADDR openoint/sdno-driver-simul-l3vpn
sleep 5

#Start openoint/sdno-driver-simul-sfc
docker run -d -i -t --name d-sfc -e MSB_ADDR=$MSB_ADDR openoint/sdno-driver-simul-sfc
sleep 5

#Start openoint/sdno-driver-simul-overlay
docker run -d -i -t --name d-overlay -e MSB_ADDR=$MSB_ADDR openoint/sdno-driver-simul-overlay
sleep 5

#Start openoint/sdno-service-nslcm
docker run -d -i -t --name s-nslcm -e MSB_ADDR=$MSB_ADDR openoint/sdno-service-nslcm
sleep 5

#Start openoint/sdno-service-vpc
docker run -d -i -t --name s-vpc -e MSB_ADDR=$MSB_ADDR openoint/sdno-service-vpc
