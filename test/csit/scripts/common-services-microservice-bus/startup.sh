#!/bin/bash

${WORKSPACE}/test/csit/docker/scripts/build-docker-image.sh common-services-microservice-bus
docker run --name msb -d common-services-microservice-bus
MSB_IP=`docker inspect --format '{{ .NetworkSettings.IPAddress }}' msb`
echo $MSB_IP

# wait for MSB to initialize
sleep 2

ROBOT_VARIABLES="-v MSB_IP:${MSB_IP}"
