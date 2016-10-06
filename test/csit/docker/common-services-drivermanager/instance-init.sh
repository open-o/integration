#!/bin/bash -v

# Initialize DB schema
mysql -uroot -prootpass < init/drivermanagerservice_tables_mysql.sql

# missing executable permissions
chmod +x bin/*.sh
sleep 1
