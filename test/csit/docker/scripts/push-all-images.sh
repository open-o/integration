#!/bin/sh
# $1 org

if [ -z "$1" ]; then
    ORG="openoint"
else
    ORG=$1
fi

set -exu

VERSION="1.0.0"

# docker root dir
ROOT=`git rev-parse --show-toplevel`/test/csit/docker

cd $ROOT
for file in `find -name Dockerfile | sort`; do
    dir=$(dirname $file)
    image=$(basename $dir)
    echo 
    echo $image
    docker push $ORG/$image:$VERSION
    docker push $ORG/$image:latest
done
