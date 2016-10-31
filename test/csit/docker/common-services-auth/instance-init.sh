#!/bin/bash -v

# Initialize DB schema
mysql -uroot -prootpass < init/keystone_tables_mysql.sql

# Configure keystone
openssl rand -hex 10 > admin_token.txt

ADMIN_TOKEN=`cat admin_token.txt`
KEYSTONE_PORT=5000

sed -i "s|IP=.*|IP=127.0.0.1|" webapps/ROOT/WEB-INF/classes/auth_service.properties
sed -i "s|PORT=.*|PORT=$KEYSTONE_PORT|" webapps/ROOT/WEB-INF/classes/auth_service.properties
cat webapps/ROOT/WEB-INF/classes/auth_service.properties

sed -i "s|admin_token=.*|admin_token=$ADMIN_TOKEN|" webapps/ROOT/WEB-INF/classes/keystone_config.properties
cat webapps/ROOT/WEB-INF/classes/keystone_config.properties

sed -i "s|#admin_token.*|admin_token=$ADMIN_TOKEN|" /etc/keystone/keystone.conf
sed -i "s|#public_port.*|public_port=$KEYSTONE_PORT|" /etc/keystone/keystone.conf
cat /etc/keystone/keystone.conf | egrep -v '^[[:space:]]*$|^ *#'

sed -i "/^\[DEFAULT\]$/aadmin_token = $ADMIN_TOKEN" /etc/keystone/keystone.conf
sed -i '/^\[DEFAULT\]$/averbose = True' /etc/keystone/keystone.conf
sed -i '/^\[database\]$/aconnection = mysql://keystone:root@127.0.0.1/keystone' /etc/keystone/keystone.conf
sed -i '/^\[memcache\]$/aservers = localhost:11211' /etc/keystone/keystone.conf
sed -i '/^\[token\]$/aprovider = uuid' /etc/keystone/keystone.conf
sed -i '/^\[token\]$/adriver = memcache' /etc/keystone/keystone.conf
sed -i '/^\[revoke\]$/adriver = sql' /etc/keystone/keystone.conf

#config httpd and run it
sed -i '/\#ServerName www.example.com:80$/aServerName controller' /etc/httpd/conf/httpd.conf
cp init/wsgi-keystone.conf  /etc/httpd/conf.d/wsgi-keystone.conf

#Populate the Identity service database
su -s /bin/sh -c "keystone-manage db_sync" keystone

