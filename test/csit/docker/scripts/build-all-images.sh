#!/bin/sh

# docker root dir
ROOT=`git rev-parse --show-toplevel`/test/csit/docker

cd $ROOT
for file in `find -name Dockerfile`; do
    image=$(basename `dirname $file`)
    echo 
    echo $image
    docker build -t $image $image
done
