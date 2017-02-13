#!/bin/bash
MOCO_JAR="moco-runner-0.11.0-standalone.jar"
DRIVERMANAGER_URL="/openoapi/drivermgr/v1/drivers"

OVERLAY_TEMPLATE_FILE="template-overlay-driver.json"
OVERLAY_SIMU_FILE="overlay_sim_file.json"
OVERLAY_DRIVER_SIMU_FILENAME="OverlayDriver.json"

SERVICE_TYPE="http"
DRIVER_LISTEN_PORT="8536";
DRIVER_SHUTDOWN_PORT="18536";
LOG_FILENAME="./logs/moco.log"

mkdir -p logs

DRIVER_IP=`ifconfig  eth0| grep "inet " | awk '{print $2}'`
cat $OVERLAY_TEMPLATE_FILE | sed -e 's/DRIVER_IP/$DRIVER_IP/g' > $OVERLAY_SIMU_FILE

#Register OVERLAY Driver to Driver Manager
curl -d @$OVERLAY_SIMU_FILE -H "Content-Type: application/json;charset=UTF-8" http://$MSB_IP$DRIVERMANAGER_URL

#Start the simulated driver for OVERLAY
java -jar $MOCO_JAR $SERVICE_TYPE -p $DRIVER_LISTEN_PORT  -s $DRIVER_SHUTDOWN_PORT -c  $OVERLAY_DRIVER_SIMU_FILENAME | tee -a $LOG_FILENAME
tail $LOG_FILENAME