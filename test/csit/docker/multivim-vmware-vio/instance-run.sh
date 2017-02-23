#!/bin/bash -v

redis-server &

cd ./vio
./run.sh

while [ ! -f logs/runtime_vio.log ]; do
    sleep 1
done
tail -F logs/runtime_vio.log
