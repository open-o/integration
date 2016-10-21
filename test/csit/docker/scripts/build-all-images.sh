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
    docker build -t openoint/$image:$VERSION -t openoint/$image:latest $dir
done
