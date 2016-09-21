#!/bin/bash

# Start mysql
su mysql -c /usr/bin/mysqld_safe &
sleep 2

# Initialize DB schema
mysql -uroot < dbscripts/mysql/openo-common_tosca-catalog-createobj.sql

# Start service
/service/run.sh
