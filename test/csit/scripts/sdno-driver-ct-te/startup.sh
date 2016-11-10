#!/bin/bash
# $1 nickname for the CATALOG instance
# $2 IP address of MSB
source ${SCRIPTS}/common_functions.sh

#Start openoint/sdno-driver-ct-te
run-instance.sh openoint/sdno-driver-ct-te $1 " -i -t -e MSB_ADDR=$2"

curl_path='http://'$2'/openoapi/drivermgr/v1/drivers'
sleep_msg="Waiting_url_for_"$1
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' REPEAT_NUMBER=10 GREP_STRING="\[\]" EXCLUDE_STRING