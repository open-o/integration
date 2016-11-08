#!/bin/bash
# $1 nickname for the CATALOG instance
# $2 IP address of MSB
echo $@

#Start L3VPN
run-instance.sh openoint/sdno-service-l3vpn i-l3vpn " -i -t -e MSB_ADDR=$2"
for i in {1..25}; do
    str=`curl -sS http://$2/openoapi/microservices/v1/services/sdnol3vpn/version/v1 | grep -v status`
    if [[ -z $str ]] ; then echo "empyt/null"; break; fi
    echo "L3VPN wait" sleep $i
    sleep $i
done