# Configure MSB IP address
sed -i "s|msbServerAddr:.*|msbServerAddr: http://$MSB_ADDR|" catalog/conf/catalog.yml
cat catalog/conf/catalog.yml
