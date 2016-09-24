#!/bin/sh

# docker root dir
ROOT=`git rev-parse --show-toplevel`/test/csit/docker

cd $ROOT
for file in `find -name Dockerfile`; do
    dir=`dirname $file`
    cat > $dir/Dockerfile <<EOF
#
# This file was auto-generated; do not modify manually.  Instead, modify the component
# templates and then run gen-all-dockerfiles.sh to re-generate.
#
# $dir Dockerfile
#
EOF
    cat $dir/*.txt >> $dir/Dockerfile
done
