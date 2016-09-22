#!/bin/bash
# $1 project
# $2 functionality
# $3 robot options
# $4 ci-management repo location

if [ $# -eq 0 ]
then
    echo "Usage: $0 <project>/<functionality> [<robot-options>] [<ci-management-dir>]"
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
export TESTPLAN="${1}"
export TESTOPTIONS="${2}"

if [ -z "$3" ]; then
    CI=${WORKSPACE}/../ci-management
else
    CI=${3}
fi


TESTS=${WORKSPACE}/test/csit/plans/${TESTPLAN}/testplan.txt
if [ ! -f $TESTS ]; then
    echo "testplan not found: ${TESTS}"
    exit 2
fi


# Assume that if ROBOT_VENV is set, we don't need to reinstall robot
if [ -f ${WORKSPACE}/env.properties ]; then
    source ${WORKSPACE}/env.properties
fi
if [ ! -f "${ROBOT_VENV}/bin/pybot" ]; then
    rm -f ${WORKSPACE}/env.properties
    source $CI/jjb/integration/include-raw-integration-install-robotframework.sh
    source ${WORKSPACE}/env.properties
fi

WORKDIR=`mktemp -d --suffix=-robot-workdir`
cd $WORKDIR

source ${ROBOT_VENV}/bin/activate

set -exu

# Run setup script plan if it exists
SETUP=${WORKSPACE}/test/csit/plans/${TESTPLAN}/setup.sh
if [ -f ${SETUP} ]; then
    echo "Running setup script ${SETUP}"
    source ${SETUP}
fi

# Run test plan
echo "Reading the testplan:"
cat ${WORKSPACE}/test/csit/plans/${TESTPLAN}/testplan.txt | sed "s:integration:${WORKSPACE}:" > testplan.txt
cat testplan.txt
SUITES=$( egrep -v '(^[[:space:]]*#|^[[:space:]]*$)' testplan.txt | tr '\012' ' ' )

echo "Starting Robot test suites ${SUITES} ..."
pybot -N ${TESTPLAN} -v WORKSPACE:/tmp ${TESTOPTIONS} ${SUITES} || true

# Run teardown script plan if it exists
TEARDOWN=${WORKSPACE}/test/csit/plans/${TESTPLAN}/teardown.sh
if [ -f ${TEARDOWN} ]; then
    echo "Running teardown script ${TEARDOWN}"
    source ${TEARDOWN}
fi

# TODO: do something with the output

