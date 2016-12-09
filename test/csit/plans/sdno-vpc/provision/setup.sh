# These scripts are sourced by run-csit.sh.
#!/bin/bash

source ${SCRIPTS}/common_functions.sh

# Start MSB
${SCRIPTS}/common-services-microservice-bus/startup.sh i-msb
MSB_IP=`get-instance-ip.sh i-msb`
curl_path='http://'${MSB_IP}'/openoui/microservices/index.html'
sleep_msg="Waiting_connection_for_url_for:i-msb"
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' GREP_STRING="org_openo_msb_route_title" REPEAT_NUMBER="15"

# Start BRS
${SCRIPTS}/sdno-brs/startup.sh i-brs ${MSB_IP}:80
BRS_IP=`get-instance-ip.sh i-brs`

#Start openoint/common-services-drivermanager
run-instance.sh openoint/common-services-drivermanager d-drivermgr " -i -t -e MSB_ADDR=${MSB_IP}:80"
curl_c='http://'${MSB_IP}':80/openoapi/drivermgr/v1/drivers'
sleep_msg="DRIVER_MANAGER_load"

#Start openoint/common-services-extsys
run-instance.sh openoint/common-services-extsys i-common-services-extsys " -i -t -e MSB_ADDR=${MSB_IP}:80"
extsys_ip=`get-instance-ip.sh i-common-services-extsys`
sleep_msg="Waiting_for_i-common-services-extsys"
curl_path='http://'${MSB_IP}':80/openoapi/extsys/v1/vims'
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE='"$sleep_msg"' REPEAT_NUMBER=25 GREP_STRING="\["

#Start VPC
${SCRIPTS}/sdno-vpc/startup.sh s-vpc ${MSB_IP}:80
BRS_IP=`get-instance-ip.sh s-vpc`

# Start Huawei Openstack
run-instance.sh openoint/sdno-driver-huawei-openstack d-driver-huawei-openstack " -i -t -e MSB_ADDR=${MSB_IP}:80"

# Copy json files used in tests
cp ${WORKSPACE}/test/csit/${TESTPLAN}/*.json ${WORKDIR}

# Start moco runner
cp ${WORKSPACE}/bootstrap/start-service-script/mocomaster/moco-runner-0.11.0-standalone.jar ./
java -jar moco-runner-0.11.0-standalone.jar http -p 10002 -c moco-acdc-controller.json &
sleep 5

DRIVER_MANAGER_IP=`docker inspect --format '{{ .NetworkSettings.IPAddress }}' d-drivermgr`
SERVICE_IP=`docker inspect --format '{{ .NetworkSettings.IPAddress }}' i-common-services-extsys`
VPC_IP=`docker inspect --format '{{ .NetworkSettings.IPAddress }}' s-vpc`

ROBOT_VARIABLES="-v MSB_IP:${MSB_IP} -v SERVICE_IP:${SERVICE_IP} -v DRIVER_MANAGER_IP:${DRIVER_MANAGER_IP} -v VPC_IP:${VPC_IP}"
