#!/bin/bash -v

redis-server &

cd ./newton
./run.sh

while [ ! -f logs/runtime_newton.log ]; do
    sleep 1
done
tail -F logs/runtime_newton.log
