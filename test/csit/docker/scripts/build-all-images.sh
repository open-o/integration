#!/bin/sh

set -exu

# docker root dir
ROOT=`git rev-parse --show-toplevel`/test/csit/docker

cd $ROOT
for file in `find -name Dockerfile`; do
    dir=$(dirname $file)
    image=$(basename $dir)
    echo 
    echo $image
    docker build -t $image $dir
done
