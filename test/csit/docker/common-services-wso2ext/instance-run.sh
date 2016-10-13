# Start wso2bps
./wso2bps/bin/wso2server.sh --start
sleep 3

# Start service
./run.sh
sleep 1
tail -F wso2bps-ext/logs/wso2bpel-ext.log
