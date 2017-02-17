#!/bin/bash
#
#
# Copyright 2016 [ZTE] and others.
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
source /etc/profile
source /root/.bash_profile
alias cp='cp -f'
alias mv='mv -f'
alias rm='rm -f'
basepath=$(cd `dirname $0`; pwd)
#check input params
#if [ "$1" = "" ]; then
#    echo "install extsys faild, please input the valid params, the first param is extsys version path of ftp server"
#    exit 1
#fi
install_path=/home/openo/extsys/
install_temp_path=/home/tmp/extsys
openo_ftp_ip="10.74.148.147"
openo_version_ftp_path="$1/openo-commonservice-extsys-*linux64.tar.gz"
openo_version_name="openo-commonservice-extsys.tar.gz"
stopShellFile="${install_path}/stop.sh"
startShellFile="${install_path}/run.sh"
initShellFile="${install_path}/initDB.sh"
echo "basepath:$basepath"
cd "$basepath"
prepareEnviroment()
{
## stop extsys    
    if [ ! -f "${stopShellFile}" ]; then 
      echo " stop  shell file not exit" 
    else
      echo "execute stop extsys shell file"
      chmod +x "${stopShellFile}"
      ${stopShellFile}
    fi
##delete old version
    echo "start delete old version"
    rm -rf    $install_path
    rm -rf    $install_temp_path
## create install path
   echo "start create new version path"
   mkdir  -p $install_path   
   mkdir -p $install_temp_path  
##get extsys version
   echo "start get extsys version"
   scp root@$openo_ftp_ip:$openo_version_ftp_path $install_temp_path/$openo_version_name
}
install()
{
## unzip extsys version  
   echo "start unzip extsys version"
   tar -zxvf  $install_temp_path/${openo_version_name} -C ${install_path}
   chmod +x ${install_path}/*.sh
## init extsys
   echo "start init extsys"
   $initShellFile root U_tywg_2013 3306 127.0.0.1
## start extsys
   echo "start  extsys"
   sh $startShellFile &
   echo "extsys install success!"
}
prepareEnviroment
install

