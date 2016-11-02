#!/bin/bash
# $1 nickname for the CATALOG instance
# $2 IP address of MSB
echo $@

#Start MSS
run-instance.sh openoint/sdno-service-mss i-mss "-e MSB_ADDR=$2"
for i in {1..25}; do
	str=`curl -sS http://$2/openoapi/sdnomss/v1/sites`
	if [[ -z $str ]] ; then echo "empyt/null"; break; fi
    echo "MSS wait" sleep $i
    sleep $i
done

#Start BRS
run-instance.sh openoint/sdno-service-brs $1 " -i -t -e MSB_ADDR=$2"
for i in {1..25}; do
	str=`curl -sS http://$2/openoapi/sdnobrs/v1/sites | grep -v "totalNum"`
	if [[ -z $str ]] ; then echo "empyt/null"; break; fi
    echo "BRS wait" sleep $i
    sleep $i
done
