# These scripts are sourced by run-csit.sh.
source ${SCRIPTS}/common_functions.sh

# Start MSB
${SCRIPTS}/common-services-microservice-bus/startup.sh i-msb
MSB_IP=`get-instance-ip.sh i-msb`
sleep_msg="Waiting_for_MSB_load"
curl_path='http://'${MSB_IP}'/openoui/microservices/index.html'
wait_curl_driver CURL_COMMAND=$curl_path WAIT_MESSAGE="$sleep_msg" REPEAT_NUMBER=10 GREP_STRING="org_openo_msb_route_title"

# Start BRS
${SCRIPTS}/sdno-brs/startup.sh i-brs ${MSB_IP}:80
BRS_IP=`get-instance-ip.sh i-brs`

${SCRIPTS}/sdno-l3vpn/startup.sh s-l3vpn ${MSB_IP}:80
BRS_IP=`get-instance-ip.sh s-l3vpn`

SERVICE_PORT='8506'
SERVICE_NAME='sdnol3vpn'

# Pass any variables required by Robot test suites in ROBOT_VARIABLES
ROBOT_VARIABLES="-v MSB_IP:${MSB_IP}  -v BRS_IP:${BRS_IP} -v SERVICE_PORT:${SERVICE_PORT} -v SERVICE_NAME:${SERVICE_NAME}"