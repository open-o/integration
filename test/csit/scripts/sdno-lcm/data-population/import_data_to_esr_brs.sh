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
#use JSON qw( encode_json decode_json );

#### Check arguments
[ $# -ne 5 ] && { 
     echo "Usage: $0 <MSB_ADDR[ipv4:port]> <CONTROLLERS_SIMULATOR_IP[ipv4]> <CONTROLLERS_FILE_NAME[json]> <SITE_FILE_NAME[json]> <MANAGED_ELEMENTS_FILE_NAME[json]>";
     exit 1;}

#MSB address, the IP address on which these controllers will be simulated, controllers meta-data file, and managed elements meta-data file.
MSB_ADDR=$1
CONTROLLERS_SIMULATOR_IP=$2
CONTROLLERS_FILE_NAME=$3
SITE_FILE_NAME=$4
MES_FILE_NAME=$5

#ME registration body prefix in JSON
ME_JSON_PREFIX="managedElement";

#API urls for register site and MEs to BRS
ME_REG_API_URL="/openoapi/sdnobrs/v1/managed-elements";
SITE_REG_API_URL="/openoapi/sdnobrs/v1/sites";


####################################IMPORT CONTROLLERS TO ESR##############################
#used to hold the controller ids returned from ESR
#HashMap
declare -A placeholderControllerMap
#Read controllers meta data
controllerContent=$(cat $CONTROLLERS_FILE_NAME | jq -c '.')
controllers_size=$(echo $controllerContent | jq '. | length'-1)
for i in $(seq 0 $controllers_size);
do
    port=$(echo $controllerContent | jq '.['$i'].port' | sed 's/\"//g')
    api_url=$(echo $controllerContent | jq '.['$i'].api_url' | sed 's/\"//g')
    rsp_id_keyname_value=$(echo $controllerContent | jq '.['$i'].rsp_id_keyname' | sed 's/\"//g')
    id_placeholder_value=$(echo $controllerContent | jq '.['$i'].id_placeholder' | sed 's/\"//g')
    reg_data=$(echo $controllerContent | jq -c '.['$i'].reg_data')
    real_address="$CONTROLLERS_SIMULATOR_IP:$port"
    reg_str=$(echo $reg_data | sed 's/CONTROLLER_IPPORT/'$real_address'/g')
    echo "CURL_COMMAND=curl -X POST -d '$reg_str' -H 'Content-Type: application/json;charset=UTF-8' http://$MSB_ADDR$api_url"
    response=$(curl -X POST -d "$reg_str" -H 'Content-Type: application/json;charset=UTF-8' http://"$MSB_ADDR$api_url")
    controller_id=$(echo $response | jq '.'$rsp_id_keyname_value'')
    placeholderControllerMap+=(["$id_placeholder_value"]="$controller_id")
done

echo "PlaceHolderId::ControllerId"
for key in "${!placeholderControllerMap[@]}";
do 
    echo "$key::${placeholderControllerMap[$key]}"
done
####################################IMPORT Site TO ESR###################################
#used to hold uuid of the site (returned by BRS

#read request body
site=$(cat $SITE_FILE_NAME | jq -c '.')
##########################insert site to BRS
site_url="http://$MSB_ADDR$SITE_REG_API_URL"

echo "CURL_COMMAND:curl -X POST -d '$site' -H 'Content-Type: application/json;charset=UTF-8' $site_url"
site_response=$(curl -X POST -d "$site" -H 'Content-Type: application/json;charset=UTF-8' "$site_url")
echo $site_response

########################get site id returned by BRS
site_id=$(echo $site_response | jq -c '.site.id' | sed 's/\"//g')
echo "SiteId:$site_id"
####################################IMPORT Managed Elements TO ESR#########################
#used to hold the me ids returned from BRS
declare -A me_ids

#read all MEs
managedElementsContent=$(cat $MES_FILE_NAME | jq -c '.')
managed_elements_size=$(echo $managedElementsContent | jq '. | length'-1)
for i in $(seq 0 $managed_elements_size);
do
    reg_str=$(echo $managedElementsContent | jq -c '.['$i']')
    name=$(echo $reg_str | jq -c '.name' | sed 's/\"//g')
    #find the controllers ids array, then remove [ and ], remove coma<,>, remove empty lines, remove double quote <"> and finally get rid of extra spaces:) 
    controllerIdValues=$(echo $reg_str | jq '.controllerID' | sed 's/\(\[\|\]\)//g' | sed 's/,//g' | sed '/^\s*$/d' | sed 's/\"//g' | sed -n 's/ *//gp')
    for placeholder in $controllerIdValues;
    do
        real_id=$(echo ${placeholderControllerMap[$placeholder]} | sed 's/\"//g')  
        reg_str=$(echo $reg_str | sed 's/'$placeholder'/'$real_id'/g')
    done

    ###########################replace with real controller_id
    #for my $placeholder (@{$me->{"controllerID"}}) {
    #    my $real_id = $controller_ids{$placeholder};
    #    $reg_str =~ s/$placeholder/$real_id/;
    #}

    ###########################replace with real site_id
    reg_str=$(echo $reg_str | sed 's/SITE-ID/'$site_id'/ig')

    ##########################insert ME to BRS
    reg_str_in_command="{\"managedElement\":"$reg_str"}"
    url="http://$MSB_ADDR$ME_REG_API_URL"
    echo "CURL_COMMAND:curl -X POST -d '$reg_str_in_command' -H 'Content-Type: application/json;charset=UTF-8' $url"
    response=$(curl -X POST -d "$reg_str_in_command" -H 'Content-Type: application/json;charset=UTF-8' "$url")
    echo $response

    ########################get id returned by BRS
    me_id=$(echo $response | jq '.managedElement.id')
    me_ids+=(["$name"]="$me_id")
done
echo "ID of the MEs registered to BRS:"
for key in "${!me_ids[@]}";
do 
    echo "$key::${me_ids[$key]}"
done