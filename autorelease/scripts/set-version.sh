#!/bin/sh

VERSION="1.0.0"

# autorelease root dir
ROOT=`git rev-parse --show-toplevel`/autorelease

BUILD_DIR=$ROOT/build

mkdir -p $BUILD_DIR
cd $BUILD_DIR

# reset wayward SNAPSHOT versions first
perl -p -i -e 's/\$\{brs\.version\}/1.0.0-SNAPSHOT/g' `find . -name pom.xml`

# workaround for master branch version merged into sun
perl -p -i -e 's/1\.1\.0+-SNAPSHOT/1.0.0-SNAPSHOT/g' `find . -name pom.xml`

if [ -z "$MVN" ]; then
    export MVN=`which mvn`
fi

# Jenkins sets a $MVN parameter via JJB that points to the appropriately installed maven
$MVN -f oparent/version/pom.xml versions:set versions:update-child-modules -DnewVersion=${VERSION}
