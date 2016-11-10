# These scripts are sourced by run-csit.sh.

# Start MSB
${SCRIPTS}/common-services-microservice-bus/startup.sh i-msb
MSB_IP=`get-instance-ip.sh i-msb`
for i in {1..10}; do
    curl -sS http://${MSB_IP}/openoui/microservices/index.html | grep "org_openo_msb_route_title" && break
    echo "MSB wait" sleep $i
    sleep $i
done

# Start BRS
${SCRIPTS}/sdno-brs/startup.sh i-brs ${MSB_IP}:80
BRS_IP=`get-instance-ip.sh i-brs`

#Start openoint/common-services-extsys
run-instance.sh openoint/common-services-extsys i-common-services-extsys " -i -t -e MSB_ADDR=${MSB_IP}:80"
extsys_ip=`get-instance-ip.sh i-common-services-extsys`
for i in {1..25}; do
    str=`curl -sS http://$extsys_ip:8100/openoapi/extsys/v1/vims | grep "\["` || str=''
    if [ "$?" = "7" ]; then
        echo 'Connection refused or cant connect to server/proxy';
    fi
    if [[ ! -z $str ]] ; then echo "common-services-extsys started"; break; fi
    echo "common-services-extsys wait" sleep $i
    sleep $i
done

#Start openoint/common-services-drivermanager
run-instance.sh openoint/common-services-drivermanager i-drivermgr " -i -t -e MSB_ADDR=${MSB_IP}:80"
for i in {1..25}; do
    str=`curl -sS http://${MSB_IP}:80/openoapi/drivermgr/v1/drivers | grep "\["` || str=''
    if [ "$?" = "7" ]; then
        echo 'Connection refused or cant connect to server/proxy';
    fi
    if [[ ! -z $str ]] ; then echo "Driver Manager started"; break; fi
    echo "DRIVERMANAGER wait" sleep $i
    sleep $i
done

#Start openoint/sdno-driver-huawei-l3vpn
${SCRIPTS}/sdno-driver-huawei-l3vpn/startup.sh i-driver-huawei-l3vpn ${MSB_IP}:80
DRIVERMGR_IP=`get-instance-ip.sh i-drivermgr`

DRIVER_PORT='8533'
DRIVER_NAME='sdnol3vpndriver-0-1'
DRIVERMGR_PORT="8103"

# Pass any variables required by Robot test suites in ROBOT_VARIABLES
ROBOT_VARIABLES="-v MSB_IP:${MSB_IP}  -v DRIVERMGR_IP:${DRIVERMGR_IP} -v DRIVERMGR_PORT:${DRIVERMGR_PORT} -v DRIVER_PORT:${DRIVER_PORT} -v DRIVER_NAME:${DRIVER_NAME} "