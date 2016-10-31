# Configure MSB IP address
sed -i "s|msbServerAddr:.*|msbServerAddr: http://$MSB_ADDR|" conf/extsys.yml
sed -i "s|serviceIp:.*|serviceIp: $SERVICE_IP|" conf/extsys.yml
cat conf/extsys.yml
