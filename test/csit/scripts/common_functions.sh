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

function memory_details(){
    #General memory details
    top -bn1 | head -3
    free -h
    echo ""
    #Memory details per Docker
    docker stats --no-stream
}

function wait_curl_driver(){
    #Parrameters:
    #CURL_COMMAND - the link on which the curl command will be executed
    #GREP_STRING - the string that should exist when returning the result of the curl command
    #EXCLUDE_STRING - eliminates the string from the curl result
    #WAIT_MESSAGE - the message displayed if the curl command needs to be repeated
    #REPEAT_NUMBER - the maxm number of times the curl command is allowed to be repeated
    #MAX_TIME - Maximum time allowed for the transfer (in seconds)
    #STATUS_CODE - A HTTP status code desired to bo found by getting the link
    #              For the moment there is a problem and the GREP_STRING still needs to exist
    #              but its value isn't taken in consideration if the desired status code is found
    #MEMORY_USAGE - If Parrameter exists show the memory usage

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

    #MAX_TIME
    if [[ $parameters == *"MAX_TIME"* ]]
    then
        max_time=`echo $parameters | sed -e 's/.*MAX_TIME=//g'`
        max_time=`echo $max_time | sed -e 's/ .*//g'`
    else
        max_time="5"
    fi

    exclude_string=""
    #EXCLUDE_STRING
    if [[ $parameters == *"EXCLUDE_STRING"* ]]
    then
        exclude_string="-v"
    fi

    status_code=""
    #STATUS_CODE
    if [[ $parameters == *"STATUS_CODE"* ]]
    then
        status_code=`echo $parameters | sed -e 's/.*STATUS_CODE=//g'`
        status_code=`echo $status_code | sed -e 's/ .*//g'`
    fi

    for i in `eval echo {1..$repeat_max}`; do
        curl -o /dev/null --silent --head --write-out '%{http_code}' $curl_path
        response_code=`curl -o /dev/null --silent --head --write-out '%{http_code}' $curl_path`
        if [[ ! -z $status_code ]] ; then
            if [ "$status_code" -eq "$response_code" ]
            then
                echo "Status code $response_code found"
                return 0
            else
                echo "$response_code found "
            fi
        else
            #GREP_STRING
            if [[ $parameters == *"GREP_STRING"* ]]
            then
                grep_command=`echo $parameters | sed -e 's/.*GREP_STRING=//g'`
                grep_command=`echo $grep_command | sed -e 's/ .*//g'`
            else
                echo "-Grep_command is empty-"  # Or no parameterseter passed.
                return 0
            fi

            str=`curl -sS -m$max_time $curl_command | grep $grep_command`
            echo "s1=" $str
            if [[ ! -z $exclude_string ]] ; then
                str_exclude=`echo $str | grep -v $grep_command`;
                if [[ ! -z $str_exclude ]] ; then
                    echo "Element found";
                    break;
                fi
            fi

            if [ "$?" = "7" ]; then
                echo 'Connection refused or cant connect to server/proxy';
                str=''
            fi

            if [[ ! -z $str ]] ; then
                echo "Element found";
                break;
            else
                echo "Element not found yet # "$i""
            fi
            echo $wait_message
        fi
        #MEMORY_USAGE
        if [[ $parameters == *"MEMORY_USAGE"* ]]
        then
            echo "==========================MEMORY USAGE=================================="
            memory_details
            echo "========================================================================"
        fi
        echo "Repeat number # "$i""
        sleep $i
    done
    return 0
}

function run_simulator ()
{
   run_robottestlib
   run_simulator_docker $1
}

function run_robottestlib ()
{
    #Start the robottest REST library if not started
    if ! pgrep -f robottest > /dev/null
    then
        #Download the latest robottest jar
        wget -q -O  ${SCRIPTS}/integration/mockserver/org.openo.robottest.jar  "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=snapshots&g=org.openo.integration&a=org.openo.robottest&e=jar&v=LATEST"
        chmod +x  ${SCRIPTS}/integration/mockserver/org.openo.robottest.jar
        eval `java -cp ${SCRIPTS}/integration/mockserver/org.openo.robottest.jar  org.openo.robot.test.robottest.MyRemoteLibrary` &
    fi
}

function run_simulator_docker ()
{
    #Start the simulator docker if not started
    SIMULATOR_IP=`docker inspect --format '{{ .NetworkSettings.IPAddress }}' simulator`
    if [[ -z $SIMULATOR_IP ]]
    then
        echo "Starting simulator docker..."
        SIMULATOR_JSON=$1
        if [[ -z $SIMULATOR_JSON ]]
        then
            SIMULATOR_JSON=main.json
        fi
        docker run -d -i -t --name simulator -e SIMULATOR_JSON=$SIMULATOR_JSON -p 18009:18009 -p 18008:18008  openoint/simulate-test-docker
        SIMULATOR_IP=`docker inspect --format '{{ .NetworkSettings.IPAddress }}' simulator`
    fi

    #Set the simulator IP in robot variables
    ROBOT_VARIABLES=${ROBOT_VARIABLES}" -v SIMULATOR_IP:${SIMULATOR_IP}  -v SCRIPTS:${SCRIPTS}"
    echo ${ROBOT_VARIABLES}
}
