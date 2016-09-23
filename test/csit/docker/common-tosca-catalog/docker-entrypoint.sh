#!/bin/bash

if [ -z "$MSB_ADDR" ]; then
    echo "Missing required variable MSB_ADDR: Microservices Service Bus address <ip>:<port>"
    exit 1
fi

# Configure MSB IP address
sed -i "s|msbServerAddr:.*|msbServerAddr: http://$MSB_ADDR|" conf/catalog.yml
cat conf/catalog.yml


# Start mysql
su mysql -c /usr/bin/mysqld_safe &
sleep 2

# Set mysql root password
/usr/bin/mysqladmin -u root password 'rootpass'

# Initialize DB schema
./initDB.sh root rootpass 3306 127.0.0.1

# Start service
./run.sh
