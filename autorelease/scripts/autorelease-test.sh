#!/bin/sh

# autorelease root dir
ROOT=`git rev-parse --show-toplevel`/autorelease
GERRIT_BRANCH='sun'

BUILD_DIR=$ROOT/build

mkdir -p $BUILD_DIR
cd $BUILD_DIR

TMPDIR=`mktemp -d`
git checkout pom.xml

while read p; do
    cd $BUILD_DIR
    if [ -e $BUILD_DIR/$p ]; then
	cd $BUILD_DIR/$p
	git checkout $GERRIT_BRANCH
	git reset --hard
	git pull
    else
	#TODO: replace with https once repo is open to public
	git clone -b $GERRIT_BRANCH ssh://gerrit.open-o.org:29418/$p
    fi
done < $ROOT/java-projects.txt

cd $BUILD_DIR
$ROOT/scripts/fix-relativepaths.sh
$ROOT/scripts/set-version.sh
mvn clean deploy -q -DaltDeploymentRepository=staging::default::file:$TMPDIR -DskipTests=true -Dcheckstyle.skip=true
echo "TMPDIR=$TMPDIR"
