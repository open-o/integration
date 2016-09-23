#!/bin/bash
# $1 docker image path under ${WORKSPACE}/test/csit/docker/
# $2 nickname for the instance
# $3 docker run options, e.g. variables

build-image.sh $1
docker run --name $2 $3 -d $1
