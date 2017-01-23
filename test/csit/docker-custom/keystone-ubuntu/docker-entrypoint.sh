#!/bin/bash
#
# Copyright 2016-2017 Huawei Technologies Co., Ltd.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

export OS_SERVICE_TOKEN=`cat admin_token.txt`
echo OS_SERVICE_TOKEN=$OS_SERVICE_TOKEN
export OS_SERVICE_ENDPOINT=http://controller:35357/v2.0
echo OS_SERVICE_ENDPOINT=$OS_SERVICE_ENDPOINT

sed -i "s|#admin_token.*|admin_token=$OS_SERVICE_TOKEN|" /etc/keystone/keystone.conf
sed -i "s|#verbose.*|verbose=true|" /etc/keystone/keystone.conf

savelog -n nohup.out
nohup keystone-all --config-file /etc/keystone/keystone.conf &

if [ ! -e init.log ]; then
    sleep 1
    
    keystone tenant-create --name admin --description "Admin Tenant" | tee -a init.log
    keystone user-create --name admin --pass Test1234_ --email openo@huawei.com | tee -a init.log
    keystone role-create --name admin | tee -a init.log
    keystone user-role-add --user admin --tenant admin --role admin | tee -a init.log
    keystone service-create --name keystone --type identity \--description "OpenStack Identity" | tee -a init.log
    keystone endpoint-create \
	     --service-id $(keystone service-list | awk '/ identity / {print $2}') \
	     --publicurl http://controller:5000/v2.0 \
	     --internalurl http://controller:5000/v2.0 \
	     --adminurl http://controller:35357/v2.0 \
	     --region regionOne | tee -a init.log

fi

tail -F -n +1 nohup.out
