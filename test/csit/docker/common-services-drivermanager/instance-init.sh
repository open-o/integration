#!/bin/bash -v

# Initialize DB schema
mysql -uroot -prootpass < init/drivermanagerservice_tables_mysql.sql

# Set mysql password
sed -i 's|Changeme_123|rootpass|' webapps/ROOT/WEB-INF/classes/mybatis/configuration/configuration.xml
