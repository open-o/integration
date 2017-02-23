#!/bin/bash -v

redis-server &

cd ./kilo
./run.sh

while [ ! -f logs/runtime_kilo.log ]; do
    sleep 1
done
tail -F logs/runtime_kilo.log
