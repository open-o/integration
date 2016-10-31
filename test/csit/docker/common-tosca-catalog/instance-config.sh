# Configure MSB IP address
sed -i "s|msbServerAddr:.*|msbServerAddr: http://$MSB_ADDR|" catalog/conf/catalog.yml
sed -i "s|serviceIp:.*|serviceIp: $SERVICE_IP|" catalog/conf/catalog.yml
cat catalog/conf/catalog.yml
