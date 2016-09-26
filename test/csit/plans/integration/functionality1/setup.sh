# Place the scripts in run order:
source ${WORKSPACE}/test/csit/scripts/integration/script1.sh

docker run --name i-mock -d jamesdbloom/mockserver
MOCK_IP=`get-instance-ip.sh i-mock`

# Wait for initialization
for i in {1..10}; do
    curl -sS ${MOCK_IP}:1080 && break
    echo sleep $i
    sleep $i
done

${WORKSPACE}/test/csit/scripts/integration/mock-hello.sh ${MOCK_IP}

# Pass any variables required by Robot test suites in ROBOT_VARIABLES
ROBOT_VARIABLES="-v MOCK_IP:${MOCK_IP}"

