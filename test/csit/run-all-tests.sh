#!/bin/bash

set -e

ROOT=`git rev-parse --show-toplevel`
CSIT=$ROOT/test/csit
cd $CSIT/plans

# break the name up using the first dash, since run-csit.sh just join them anyway
for file in */*/testplan.txt; do
    testplan=`dirname $file`

    echo 
    echo "#############################################################################"
    echo "Running test plan $testplan"
    echo "#############################################################################"
    $CSIT/run-csit.sh $testplan
    echo 
done
