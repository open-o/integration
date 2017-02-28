#!/bin/bash
#
# Copyright 2016-2017 ZTE Corporation
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
#    echo "install catalog faild, please input the valid params, the first param is catalog version path of ftp server"
#    exit 1
#fi
install_path=/home/openo/catalog
install_temp_path=/home/tmp/catalog
yam_parser_path=/home/openo/yaml-parser
openo_ftp_ip="10.74.148.147"
openo_version_ftp_path="$1/openo-commontosca-catalog-*linux64.tar.gz"
openo_version_name="openo-commontosca-catalog.tar.gz"
stopShellFile="${install_path}/shutdown.sh"
startShellFile="${install_path}/startup.sh"
initShellFile="${install_path}/catalog/initDB.sh"
echo "basepath:$basepath"
cd "$basepath"
prepareEnviroment()
{  
### stop yaml parser 
    if [ ! -f "${yam_parser_path}/stop.sh" ]; then 
      echo " stop yaml parser shell file not exit" 
    else
      echo "execute stop catalog shell file"
      chmod +x "${yam_parser_path}/stop.sh"
      ${yam_parser_path}/stop.sh
    fi
## stop catalog 
    if [ ! -f "${stopShellFile}" ]; then 
      echo " stop  shell file not exit" 
    else
      echo "execute stop catalog shell file"
      chmod +x "${stopShellFile}"
      ${stopShellFile}
    fi
##delete old version
    echo "start delete old version"
    rm -rf    $install_path
    rm -rf    $install_temp_path
## create install path
   echo "start create new version path"
   mkdir -p $install_path   
   mkdir -p $install_temp_path  
##get catalog version
   echo "start get catalog version"
   scp root@$openo_ftp_ip:$openo_version_ftp_path $install_temp_path/$openo_version_name
}
install()
{
## unzip catalog version  
   echo "start unzip catalog version"
   tar -zxvf  $install_temp_path/${openo_version_name} -C ${install_path}
   chmod +x ${install_path}/*.sh
## init catalog
   echo "start init catalog"
   $initShellFile root U_tywg_2013 3306 127.0.0.1  
## modify http server ip
   sed -i -e "s/^.*httpServerAddr:.*$/httpServerAddr: http:\/\/10.74.148.43:8201/" ${install_path}/catalog/conf/catalog.yml
   sed -i -e "s/^.*msbServerAddr:.*$/msbServerAddr: http:\/\/10.74.148.43:80/" ${install_path}/catalog/conf/catalog.yml
   
## start yaml parser
   echo "start yaml parser"
   chmod +x ${yam_parser_path}/run.sh
   ${yam_parser_path}/run.sh &
## start catalog
   echo "start  catalog"
   sh $startShellFile &
   echo "catalog install success!"
}
prepareEnviroment
install

