#!/bin/bash -v
# $1 nickname for the instance

mkdir -p $WORKSPACE/archives

docker logs $1 >> $WORKSPACE/archives/$1.log
docker kill $1
docker rm $1

