#!/bin/bash -v
cd ./nfvo/drivers/vnfm/svnfm/zte/vmanager
./run.sh

while [ ! -f logs/runtime_driver.log ]; do
    sleep 1
done
tail -F logs/runtime_driver.log
