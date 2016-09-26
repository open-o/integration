# These scripts are sourced by run-csit.sh.

# Start MSB
${SCRIPTS}/common-services-microservice-bus/startup.sh i-msb
MSB_IP=`get-instance-ip.sh i-msb`
echo MSB_IP=${MSB_IP}

# Start catalog
${SCRIPTS}/common-tosca-catalog/startup.sh i-catalog ${MSB_IP}
CATALOG_IP=`get-instance-ip.sh i-catalog`
echo CATALOG_IP=${CATALOG_IP}

# Wait for initialization
for i in {1..10}; do
    curl -sS -m 1 ${CATALOG_IP}:8200 && curl -sS -m 1 ${MSB_IP}:80 && break
    echo sleep $i
    sleep $i
done

# Pass any variables required by Robot test suites in ROBOT_VARIABLES
ROBOT_VARIABLES="-v MSB_IP:${MSB_IP} -v CATALOG_IP:${CATALOG_IP}"

