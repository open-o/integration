#!/bin/bash
# $1 nickname for the CATALOG instance
# $2 IP address of MSB
source ${SCRIPTS}/common_functions.sh
echo $@

#Start DRIVER HUAWEI SERVICECHAIN
run-instance.sh openoint/sdno-driver-huawei-servicechain d-driver-huawei-servicechain " -i -t -e MSB_ADDR=$2"
curl_path='http://'$2'/openoapi/drivermgr/v1/drivers'
sleep_msg="Waiting_connection_of_url_for:"$1
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' GREP_STRING="\[\]" EXCLUDE_STRING