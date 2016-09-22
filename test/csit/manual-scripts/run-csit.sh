#!/bin/bash
# $1 project
# $2 functionality
# $3 robot options
# $4 ci-management repo location

if [ $# -eq 0 ]
then
    echo "Usage: $0 <project> <functionality> <robot-options> [<ci-management-dir>]"
    echo
    echo "    <project>, <functionality>, <robot-options>:  "
    echo "        The same values as for the '{project}-csit-{functionality}' JJB job template."
    echo
    echo "    <ci-management-dir>: "
    echo "        Path to the ci-management repo checked out locally.  It not specified, "
    echo "        assumed to be adjacent to the integration repo directory."
    echo
    exit 1
fi

export WORKSPACE=`git rev-parse --show-toplevel`
export TESTPLAN="${1}-${2}.txt"
export TESTOPTIONS="${3}"

if [ -z "$4" ]; then
    CI=${WORKSPACE}/../ci-management
else
    CI=${4}
fi

if [ ! -f ${WORKSPACE}/test/csit/testplans/${TESTPLAN} ]; then
    echo "testplan not found: ${WORKSPACE}/test/csit/testplans/${TESTPLAN}"
    exit 2
fi

WORKDIR=`mktemp -d --suffix=-robot-workdir`
cd $WORKDIR

source $CI/jjb/integration/include-raw-integration-install-robotframework.sh

mv ${WORKSPACE}/env.properties ${WORKDIR}
source ${WORKDIR}/env.properties

source $CI/jjb/integration/include-raw-integration-run-test.sh

rm -rf ${ROBOT_VENV}

