#!/bin/bash
MOCO_JAR="moco-runner-0.11.0-standalone.jar"
DRIVERMANAGER_URL="/openoapi/drivermgr/v1/drivers"

L3VPN_TEMPLATE_FILE="template-l3vpn-driver.json"
L3VPN_SIMU_FILE="l3vpn_sim_file.json"
L3VPN_DRIVER_SIMU_FILENAME="L3vpnDriver.json"

SERVICE_TYPE="http"
DRIVER_LISTEN_PORT="8533";
DRIVER_SHUTDOWN_PORT="18533";
LOG_FILENAME="./logs/moco.log"

mkdir -p logs

DRIVER_IP=`ifconfig  eth0| grep "inet " | awk '{print $2}'`
cat $L3VPN_TEMPLATE_FILE | sed -e 's/DRIVER_IP/$DRIVER_IP/g' > $L3VPN_SIMU_FILE

#Register L3VPN Driver to Driver Manager
curl -d @$L3VPN_SIMU_FILE -H "Content-Type: application/json;charset=UTF-8" http://$MSB_IP$DRIVERMANAGER_URL

#Start the simulated driver for L3VPN
java -jar $MOCO_JAR $SERVICE_TYPE -p $DRIVER_LISTEN_PORT  -s $DRIVER_SHUTDOWN_PORT -c  $L3VPN_DRIVER_SIMU_FILENAME | tee -a $LOG_FILENAME
tail $LOG_FILENAME