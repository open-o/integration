# Configure MSB IP address
sed -i "s|msbServerAddr:.*|msbServerAddr: http://$MSB_ADDR|" conf/wso2bpel.yml
cat conf/wso2bpel.yml
