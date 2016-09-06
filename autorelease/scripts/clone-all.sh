#!/bin/sh

# autorelease root dir
ROOT=`git rev-parse --show-toplevel`/autorelease

BUILD_DIR=$ROOT/build

mkdir -p $BUILD_DIR
cd $BUILD_DIR

while read p; do
    #TODO: replace with https once repo is open to public
    git clone ssh://gwu@gerrit.open-o.org:29418/$p
done < $ROOT/all-projects.txt

