# Configure MSB IP address
sed -i "s|msbServerAddr:.*|msbServerAddr: http://$MSB_ADDR|" conf/inventory.yml
sed -i "s|serviceIp:.*|serviceIp: $SERVICE_IP|" conf/inventory.yml
cat conf/inventory.yml
