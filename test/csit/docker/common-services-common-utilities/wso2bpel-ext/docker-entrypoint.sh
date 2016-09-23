#!/bin/bash

# Start wso2bps
./wso2bps-3.6.0/bin/wso2server.sh --start
sleep 3

# Start service
./run.sh
