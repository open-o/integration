#!/bin/bash

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

function wait_curl_driver(){
    #Parrameters:
    #CURL_COMMAND - the link on which the curl command will be executed
    #GREP_STRING - the string that should exist when returning the result of the curl command
    #EXCLUDE_STRING - eliminates the string from the curl result
    #WAIT_MESSAGE - the message displayed if the curl command needs to be repeated
    #REPEAT_NUMBER - the maxm number of times the curl command is allowed to be repeated

    repeat_max=15
    parameters="$@"

    #WAIT_MESSAGE
    if [[ $parameters == *"WAIT_MESSAGE"* ]]
    then
        wait_message=`echo $parameters | sed -e "s/.*WAIT_MESSAGE=//g"`
        wait_message=`echo $wait_message | sed -e "s/ .*//g"`
    else
        wait_message=""
    fi

    #REPEAT_NUMBER
    if [[ $parameters == *"REPEAT_NUMBER"* ]]
    then
        repeat_max=`echo $parameters | sed -e "s/.*REPEAT_NUMBER=//g"`
        repeat_max=`echo $repeat_max | sed -e "s/ .*//g"`
    fi

    #CURL_COMMAND
    if [[ $parameters == *"CURL_COMMAND"* ]]
    then
        curl_command=`echo $parameters | sed -e 's/.*CURL_COMMAND=//g'`
        curl_command=`echo $curl_command | sed -e 's/ .*//g'`
    else
        echo "-Curl is empty-"  # Or no parameterseter passed.
        return 0
    fi

    #GREP_STRING
    if [[ $parameters == *"GREP_STRING"* ]]
    then
        grep_command=`echo $parameters | sed -e 's/.*GREP_STRING=//g'`
        grep_command=`echo $grep_command | sed -e 's/ .*//g'`
    else
        echo "-Grep_command is empty-"  # Or no parameterseter passed.
        return 0
    fi

    exclude_string=""
    #EXCLUDE_STRING
    if [[ $parameters == *"EXCLUDE_STRING"* ]]
    then
        exclude_string="-v"
    fi

    eval '
        for i in {1..'"$repeat_max"'}; do
            str=`curl -sS -m5 $curl_command | grep $exclude_string $grep_command` || str=''
            echo $str
            if [ "$?" = "7" ]; then
                echo 'Connection refused or cant connect to server/proxy';
            fi
            if [[ ! -z $str ]] ; then
                echo "Element found";
                break;
            else
                echo "Element not found yet # "$i""
            fi
            echo '$wait_message'
            sleep $i
        done
    '  
    return 0
}