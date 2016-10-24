#!/bin/sh

set -exu

VERSION="1.0.0-RC1"

# docker root dir
ROOT=`git rev-parse --show-toplevel`/test/csit/docker

cd $ROOT
for file in `find -name Dockerfile`; do
    dir=$(dirname $file)
    image=$(basename $dir)
    echo 
    echo $image
    docker pull openoint/$image:$VERSION
    docker pull openoint/$image:latest
done
