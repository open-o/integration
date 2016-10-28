#!/bin/bash -v

# Configure keystone
ADMIN_TOKEN=$OS_SERVICE_TOKEN
KEYSTONE_PORT=5000

sed -i "s|IP=.*|IP=127.0.0.1|" webapps/ROOT/WEB-INF/classes/auth_service.properties
sed -i "s|PORT=.*|PORT=$KEYSTONE_PORT|" webapps/ROOT/WEB-INF/classes/auth_service.properties
cat webapps/ROOT/WEB-INF/classes/auth_service.properties

sed -i "s|admin_token=.*|admin_token=$ADMIN_TOKEN|" webapps/ROOT/WEB-INF/classes/keystone_config.properties
cat webapps/ROOT/WEB-INF/classes/keystone_config.properties

sed -i "s|#admin_token.*|admin_token=$ADMIN_TOKEN|" /etc/keystone/keystone.conf
sed -i "s|#public_port.*|public_port=$KEYSTONE_PORT|" /etc/keystone/keystone.conf
sed -i "s|#verbose.*|verbose=true|" /etc/keystone/keystone.conf
cat /etc/keystone/keystone.conf | egrep -v '^[[:space:]]*$|^ *#'
