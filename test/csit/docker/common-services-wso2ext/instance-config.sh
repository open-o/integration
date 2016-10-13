# Configure MSB IP address
sed -i "s|msbServerAddr:.*|msbServerAddr: http://$MSB_ADDR|" wso2bps-ext/conf/wso2bpel.yml
cat wso2bps-ext/conf/wso2bpel.yml
