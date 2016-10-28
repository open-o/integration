#!/bin/sh

# autorelease root dir
ROOT=`git rev-parse --show-toplevel`/autorelease
GERRIT_BRANCH='sun'

BUILD_DIR=$ROOT/build

mkdir -p $BUILD_DIR
cd $BUILD_DIR

while read p; do
    rm -rf $BUILD_DIR/$p
    #TODO: replace with https once repo is open to public
    git clone -b $GERRIT_BRANCH ssh://gerrit.open-o.org:29418/$p
done < $ROOT/java-projects.txt

