#!/bin/bash

${WORKSPACE}/test/csit/docker/scripts/run-docker-image.sh common-services-microservice-bus msb
IPADDR=`docker inspect --format '{{ .NetworkSettings.IPAddress }}' msb`
echo $IPADDR

