#!/bin/bash

${WORKSPACE}/test/csit/docker/scripts/build-docker-image.sh common-services-microservice-bus
docker run --name msb -d common-services-microservice-bus
IPADDR=`docker inspect --format '{{ .NetworkSettings.IPAddress }}' msb`
echo $IPADDR
