#!/bin/bash

# Start mysql
su mysql -c /usr/bin/mysqld_safe &
sleep 2

# Set mysql root password
/usr/bin/mysqladmin -u root password 'rootpass'

# Initialize DB schema
/service/initDB.sh root rootpass 3306 127.0.0.1

# Start service
/service/run.sh
