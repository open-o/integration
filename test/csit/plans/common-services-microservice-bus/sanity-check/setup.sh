# This script is sourced by run-csit.sh before the Robot tests are run.

# Start MSB
${SCRIPTS}/common-services-microservice-bus/startup.sh i-msb
MSB_IP=`get-instance-ip.sh i-msb`
echo MSB_IP=${MSB_IP}
sleep 5

# Start Message Broker
${SCRIPTS}/common-services-message-broker/startup.sh i-activemq 
ACTIVEMQ_IP=`get-instance-ip.sh i-activemq`
echo ACTIVEMQ_IP=${ACTIVEMQ_IP}


# Wait for initialization(8086 Service Registration & Discovery, 80 api gateway)
for i in {1..10}; do
    curl -sS -m 1 ${MSB_IP}:8086 && curl -sS -m 1 ${MSB_IP}:80 && break
    echo sleep $i
    sleep $i
done


curl -H "Content-Type: application/json" -X POST -d '{"serviceName": "ActiveMQ","protocol": "TCP","nodes": [{"ip": "'${ACTIVEMQ_IP}'","port": "8161"}]}' http://${MSB_IP}/openoapi/microservices/v1/services

# Pass any variables required by Robot test suites in ROBOT_VARIABLES
ROBOT_VARIABLES="-v MSB_IP:${MSB_IP}"
