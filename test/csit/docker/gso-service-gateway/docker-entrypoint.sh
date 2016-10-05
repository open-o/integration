#!/bin/bash
#
# This file was auto-generated by gen-all-dockerfiles.sh; do not modify manually.
#
# ./gso-service-gateway/docker-entrypoint.sh
#

if [ -z "$MSB_ADDR" ]; then
    echo "Missing required variable MSB_ADDR: Microservices Service Bus address <ip>:<port>"
    exit 1
fi

# Configure service based on docker environment variables
./instance-config.sh

# Perform one-time config
if [ ! -e init.log ]; then
    # microservice-specific one-time initialization
    ./instance-init.sh

    date > init.log
fi

# Start the microservice
./instance-run.sh

