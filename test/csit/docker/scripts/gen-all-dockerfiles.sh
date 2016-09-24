#!/bin/sh

# docker root dir
ROOT=`git rev-parse --show-toplevel`/test/csit/docker

cd $ROOT
for file in `find -name Dockerfile`; do
    dir=`dirname $file`
    cat $dir/*.txt > $dir/Dockerfile
done
