# Copyright 2016-2017 Huawei Technologies Co., Ltd.

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#!/bin/bash -v

ROLE_DETAIL_FILE=etc/roles.json

pre_check()
{
	echo "Reading ---> " $ROLE_DETAIL_FILE

	if [[ -z "${ROLE_DETAIL_FILE// }" ]]; then
		   echo "Error:Please provide role json file."
		   exit
	fi
}

install_jq()
{
	# Install jq package which is required to parse json file
	export DEBIAN_FRONTEND=noninteractive >/dev/null 2>&1
	apt-get -y install jq >/dev/null 2>&1
}


initialize_schema()
{
	# Create the service entity and API endpoint
	openstack service create  --name keystone --description "OpenStack Identity" identity
	openstack endpoint create --region RegionOne   identity public http://controller:5000/v2.0
	openstack endpoint create --region RegionOne   identity internal http://controller:5000/v2.0
	openstack endpoint create --region RegionOne   identity admin http://controller:35357/v2.0

	#Create domain, projects, users
	openstack domain create --description "Default Domain" default
	openstack project create --domain default   --description "Admin Project" admin
	openstack user create --domain default --password  Changeme_123 admin

	#Install jq to read and parse roles.json
	install_jq
	
	ROLES=$( cat $ROLE_DETAIL_FILE | jq -r '.roles' )
	iterator=0
	arraySize=$( echo $ROLES | jq length )

	# Iterating the roles list, creating roles and assigning to default user : admin
	while [ "$iterator" -lt "$arraySize" ]
	do 
		rolename=$( cat $ROLE_DETAIL_FILE |  jq ".roles[$iterator]" )
		rolename=$( echo "$rolename" | tr -d '"' )
		echo "Role Name ---> "$rolename
		
		openstack role create $rolename
		echo "Adding Role Name to user  ---> "$rolename
		openstack role add --project admin --user admin $rolename
		echo "Result  0: Success and 1: Faliure ---> "$?
		iterator=`expr $iterator + 1 `
	done
}

pre_check

# run httpd
/usr/sbin/httpd
sleep 1

unset http_proxy
export OS_TOKEN=`cat admin_token.txt`
export OS_URL=http://controller:35357/v3
export OS_IDENTITY_API_VERSION=3

#initializing schema
initialize_schema

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

