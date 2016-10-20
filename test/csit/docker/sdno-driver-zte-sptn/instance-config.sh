# Configure MSB IP address
sed -i "s|msbUrl:.*|msbUrl: http://$MSB_ADDR|" conf/config.yaml
cat conf/config.yaml

sed -i "s|127\.0\.0\.1|$SERVICE_IP|" conf/driver.json
cat conf/driver.json
