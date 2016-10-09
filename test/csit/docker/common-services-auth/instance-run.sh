#!/bin/bash -v

# Start keystone
keystone-all -d -v &

# Start tomcat service
./bin/start.sh

# Show log files
echo Waiting for log file...
while [ ! -f /service/logs/* ]; do
    ps -ef
    sleep 1
done
echo /service/logs/*
tail -F /service/logs/*

