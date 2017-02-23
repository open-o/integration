#!/bin/bash -v

redis-server &

cd ./multivimbroker
./run.sh

while [ ! -f logs/runtime_multivimbroker.log ]; do
    sleep 1
done
tail -F logs/runtime_multivimbroker.log
