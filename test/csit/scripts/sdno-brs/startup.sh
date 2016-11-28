#!/bin/bash -v
# $1 nickname for the CATALOG instance
# $2 IP address of MSB
source ${SCRIPTS}/common_functions.sh
echo $@

#Start MSS
run-instance.sh openoint/sdno-service-mss i-mss "-e MSB_ADDR=$2"
curl_path='http://$2/openoapi/sdnomss/v1/sites1'
sleep_msg="Waiting_connection_for_url_for:i-mss"
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"'  REPEAT_NUMBER="15"

#Start BRS
run-instance.sh openoint/sdno-service-brs $1 " -i -t -e MSB_ADDR=$2"
curl_path='http://'$2'/openoapi/sdnobrs/v1/sites'
sleep_msg="Waiting_connection_for_url_for:"$1
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' GREP_STRING="totalNum" REPEAT_NUMBER="25" 