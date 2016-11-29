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

${SCRIPTS}/sdno-l3vpn/startup.sh i-l3vpn ${MSB_IP}:80
BRS_IP=`get-instance-ip.sh i-l3vpn`

SERVICE_PORT='8506'
SERVICE_NAME='sdnol3vpn'

# Pass any variables required by Robot test suites in ROBOT_VARIABLES
ROBOT_VARIABLES="-v MSB_IP:${MSB_IP}  -v BRS_IP:${BRS_IP} -v SERVICE_PORT:${SERVICE_PORT} -v SERVICE_NAME:${SERVICE_NAME}"