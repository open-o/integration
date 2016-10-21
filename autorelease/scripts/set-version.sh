#!/bin/sh

VERSION="1.0.0-RC1"

# autorelease root dir
ROOT=`git rev-parse --show-toplevel`/autorelease

BUILD_DIR=$ROOT/build

mkdir -p $BUILD_DIR
cd $BUILD_DIR

# Jenkins sets a $MVN parameter via JJB that points to the appropriately installed maven
$MVN -f oparent/version/pom.xml versions:set versions:update-child-modules -DnewVersion=${VERSION}
