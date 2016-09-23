#!/bin/bash
# $1 docker image path under ${WORKSPACE}/test/csit/docker/

# only rebuild if not already existing
if [ "$(docker images -q $1 2> /dev/null)" == "" ]; then
    docker build -t $1 $WORKSPACE/test/csit/docker/$1    
fi
