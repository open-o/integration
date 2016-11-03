#!/bin/sh

# autorelease root dir
ROOT=`git rev-parse --show-toplevel`/autorelease
GERRIT_BRANCH='sun'

BUILD_DIR=$ROOT/build

mkdir -p $BUILD_DIR
cd $BUILD_DIR

while read p; do
    cd $BUILD_DIR/$p
    echo $p
    git diff | cat
done < $ROOT/java-projects.txt

