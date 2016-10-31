#!/bin/bash -v

# run httpd
/usr/sbin/httpd
sleep 1

unset http_proxy
export OS_TOKEN=`cat admin_token.txt`
export OS_URL=http://controller:35357/v3
export OS_IDENTITY_API_VERSION=3
openstack service create  --name keystone --description "OpenStack Identity" identity
openstack endpoint create --region RegionOne   identity public http://controller:5000/v2.0
openstack endpoint create --region RegionOne   identity internal http://controller:5000/v2.0
openstack endpoint create --region RegionOne   identity admin http://controller:35357/v2.0

#Create projects, users, and roles
openstack project create --domain default   --description "Admin Project" admin
openstack user create --domain default   --password  Changeme_123 admin
openstack role create admin
openstack role add --project admin --user admin admin

#start memcached
/usr/bin/memcached -u root &


# Start tomcat service
./bin/start.sh

# Show log files
echo Waiting for log file...
while [ ! -f /service/logs/* ]; do
    ps -ef
    sleep 1
done
echo /service/logs/*
tail -F /service/logs/*

