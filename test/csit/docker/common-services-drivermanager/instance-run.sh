#!/bin/bash -v

# Start tomcat service
./bin/start.sh

# Show log files
echo Waiting for log file...
while [ ! -f /service/logs/* ]; do
    sleep 1
done
echo /service/logs/*
tail -F /service/logs/*

