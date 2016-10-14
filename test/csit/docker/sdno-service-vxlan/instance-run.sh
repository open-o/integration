#!/bin/bash

# proxy connection to MSB
nohup socat TCP-LISTEN:8080,fork TCP:$MSB_ADDR  </dev/null >/dev/null 2>&1 &

# Start microservice
cd bin
./start.sh

# tail -F not work on remote-fs(BTRFS/AUFS)
while [ ! -e /service/logs/application.log ]; do
    sleep 1
done
# keep shell running to prevent container from exit
tail -f /service/logs/application.log
