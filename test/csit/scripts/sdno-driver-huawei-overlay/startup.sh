#!/bin/bash
# $1 nickname for the CATALOG instance
# $2 IP address of MSB
echo $@

#Start openoint/sdno-driver-huawei-overlay
run-instance.sh openoint/sdno-driver-huawei-overlay i-driver-huawei-overlay " -i -t -e MSB_ADDR=$2"
for i in {1..25}; do
    str=`curl -sS http://$2/openoapi/drivermgr/v1/drivers | grep -v "\[\]"`
    if [[ ! -z $str ]] ; then echo "Service started"; break; fi
    echo "sdno-driver-huawei-overlay wait" sleep $i
    sleep $i
done