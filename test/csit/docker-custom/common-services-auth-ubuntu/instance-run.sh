#!/bin/bash -v

savelog -n nohup.out
nohup keystone-all --config-file /etc/keystone/keystone.conf &

if [ ! -e keystone-init.log ]; then
    sleep 1
    
    keystone tenant-create --name admin --description "Admin Tenant" | tee -a keystone-init.log
    keystone user-create --name admin --pass Test1234_ --email openo@huawei.com | tee -a keystone-init.log
    keystone role-create --name admin | tee -a keystone-init.log
    keystone user-role-add --user admin --tenant admin --role admin | tee -a keystone-init.log
    keystone service-create --name keystone --type identity \--description "OpenStack Identity" | tee -a keystone-init.log
    keystone endpoint-create \
	     --service-id $(keystone service-list | awk '/ identity / {print $2}') \
	     --publicurl http://controller:5000/v2.0 \
	     --internalurl http://controller:5000/v2.0 \
	     --adminurl http://controller:35357/v2.0 \
	     --region regionOne | tee -a keystone-init.log
fi

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

