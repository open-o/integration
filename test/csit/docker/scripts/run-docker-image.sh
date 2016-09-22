#!/bin/bash
# $1 docker image name
# $2 instance name

ROOT=$WORKSPACE/test/csit/docker

docker build -t $1 $ROOT/$1
docker run --name $2 -d $1 
