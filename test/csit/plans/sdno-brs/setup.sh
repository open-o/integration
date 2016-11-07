# These scripts are sourced by run-csit.sh.

# Start MSB
${SCRIPTS}/common-services-microservice-bus/startup.sh i-msb
MSB_IP=`get-instance-ip.sh i-msb`
for i in {1..10}; do
    curl -sS http://172.17.0.2/openoui/microservices/index.html | grep "org_openo_msb_route_title" && break
    echo "MSB wait" sleep $i
    sleep $i
done

# Start BRS
${SCRIPTS}/sdno-brs/startup.sh i-brs ${MSB_IP}:80
#BRS_IP=`get-instance-ip.sh i-brs`
BRS_IP=`get-instance-ip.sh i-brs`

# Pass any variables required by Robot test suites in ROBOT_VARIABLES
ROBOT_VARIABLES="-v MSB_IP:${MSB_IP}  -v BRS_IP:${BRS_IP}"

