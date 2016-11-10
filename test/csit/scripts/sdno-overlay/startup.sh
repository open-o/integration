#!/bin/bash
# $1 nickname for the CATALOG instance
# $2 IP address of MSB
echo $@

#Start OVERLAY
run-instance.sh openoint/sdno-service-overlayvpn i-overlay " -i -t -e MSB_ADDR=$2"
for i in {1..25}; do
    str=`curl -sS http://$2/openoapi/microservices/v1/services/sdnooverlay/version/v1 | grep -v status`
    if [[ -z $str ]] ; then echo "empyt/null"; break; fi
    echo "OVERLAY wait" sleep $i
    sleep $i
done