#!/bin/bash -v

# Configure MSB IP address
sed -i "s|msb.address=.*|msb.address=$MSB_ADDR|" etc/microservice.ini
cat etc/microservice.ini
echo

# Configure self IP address for MSB
sed -i "s|10\.229\.47\.199|$SERVICE_IP|" etc/microservice/driver_rest.json
cat etc/microservice/driver_rest.json
echo

MSB_IP=`echo $MSB_ADDR | cut -d: -f 1`
sed -i "s|IP=.*|IP=$MSB_IP|" webapps/ROOT/WEB-INF/classes/driver_manager.properties
cat webapps/ROOT/WEB-INF/classes/driver_manager.properties
echo

