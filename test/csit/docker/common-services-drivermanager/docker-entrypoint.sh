#!/bin/bash

if [ -z "$MSB_ADDR" ]; then
    echo "Missing required variable MSB_ADDR: Microservices Service Bus address <ip>:<port>"
    exit 1
fi

# Configure MSB IP address
sed -i "s|msb.address=.*|msb.address=$MSB_ADDR|" etc/microservice.ini
cat etc/microservice.ini
echo


# Initialize mysql; set root password
./init-mysql.sh


# Initialize DB schema
# TODO: 
# 

# Start tomcat service
./bin/start.sh

# Show log files
echo Waiting for log file...
while [ ! -f /service/logs/* ]; do
    sleep 1
done
echo /service/logs/*
tail -F /service/logs/*
