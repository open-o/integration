#!/bin/bash

# Start mysql
./init-mysql.sh

# Initialize DB schema
# TODO: using "test" database for now, need to change to use correct database
mysql -uroot test < /service/init/servicemanagerservice_tables_mysql.sql

# Start tomcat service
/service/bin/start.sh

# Show log files
echo Waiting for log file...
while [ ! -f /service/logs/* ]; do
    sleep 1
done
echo /service/logs/*
tail -F /service/logs/*
