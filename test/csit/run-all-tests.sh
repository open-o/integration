#!/bin/bash

set -e

ROOT=`git rev-parse --show-toplevel`
CSIT=$ROOT/test/csit

# break the name up using the first dash, since run-csit.sh just join them anyway
for file in testplans/*.txt; do
    testplan=`basename $file .txt`
    project=`echo $testplan | cut -d '-' -f 1`
    functionality=`echo $testplan | cut -d '-' -f 2-`

    echo 
    echo "#############################################################################"
    echo "Running test plan $testplan"
    echo "#############################################################################"
    $CSIT/run-csit.sh $project $functionality
    echo
    echo 
done

