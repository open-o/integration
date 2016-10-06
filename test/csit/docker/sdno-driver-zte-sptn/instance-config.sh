# Configure MSB IP address
sed -i "s|msbServerAddr:.*|msbServerAddr: http://$MSB_ADDR|" conf/config.yml
cat conf/config.yml
