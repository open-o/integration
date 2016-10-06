#!/bin/bash -v

# Initialize DB schema
mysql -uroot -prootpass < init/drivermanagerservice_tables_mysql.sql
