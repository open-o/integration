#!/bin/bash -v

# Configure MSB IP address
sed -i "s|msb.address=.*|msb.address=$MSB_ADDR|" etc/microservice.ini
cat etc/microservice.ini
echo

