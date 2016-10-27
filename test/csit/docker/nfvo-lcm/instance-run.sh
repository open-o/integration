#!/bin/bash -v

redis-server &

cd ./nfvo/lcm
./run.sh

while [ ! -f logs/runtime_lcm.log ]; do
    sleep 1
done
tail -F logs/runtime_lcm.log
