# Configure MSB IP address
sed -i "s|msbServerAddr:.*|msbServerAddr: http://$MSB_ADDR|" wso2bps-ext/conf/wso2bpel.yml
sed -i "s|serviceIp:.*|serviceIp: $SERVICE_IP|" wso2bps-ext/conf/wso2bpel.yml
cat wso2bps-ext/conf/wso2bpel.yml

sed -i "s|MSB_URL=.*|MSB_URL=http://$MSB_ADDR|" wso2bps/wso2bps-ext.properties
cat wso2bps/wso2bps-ext.properties
