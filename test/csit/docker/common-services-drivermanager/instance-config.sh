#!/bin/bash -v

# Configure MSB IP address
sed -i "s|msb.address=.*|msb.address=$MSB_ADDR|" etc/microservice.ini
cat etc/microservice.ini
echo

# Configure self IP address for MSB
sed -i "s|10\.229\.47\.199|`hostname -i`|" etc/microservice/driver_rest.json
cat etc/microservice/driver_rest.json
echo
