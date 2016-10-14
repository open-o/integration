# Configure MSB IP address
sed -i "s|msbUrl:.*|msbUrl: http://$MSB_ADDR|" conf/config.yaml
cat conf/config.yaml
