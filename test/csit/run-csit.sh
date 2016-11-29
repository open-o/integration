#!/bin/bash
# $1 project/functionality
# $2 robot options
# $3 ci-management repo location

if [ $# -eq 0 ]
then
    echo 
    echo "Usage: $0 plans/<project>/<functionality> [<robot-options>] [<ci-management-dir>]"
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

if [ -f ${WORKSPACE}/test/csit/${1}/testplan.txt ]; then
    export TESTPLAN="${1}"
else
    echo "testplan not found: ${WORKSPACE}/test/csit/${TESTPLAN}/testplan.txt"
    exit 2
fi


export TESTOPTIONS="${2}"

if [ -z "$3" ]; then
    CI=${WORKSPACE}/../ci-management
else
    CI=${3}
fi




TESTPLANDIR=${WORKSPACE}/test/csit/${TESTPLAN}

# Assume that if ROBOT_VENV is set, we don't need to reinstall robot
if [ -f ${WORKSPACE}/env.properties ]; then
    source ${WORKSPACE}/env.properties
    source ${ROBOT_VENV}/bin/activate
fi
if ! type pybot > /dev/null; then
    rm -f ${WORKSPACE}/env.properties
    source $CI/jjb/integration/include-raw-integration-install-robotframework.sh
    source ${WORKSPACE}/env.properties
    source ${ROBOT_VENV}/bin/activate
fi


WORKDIR=`mktemp -d --suffix=-robot-workdir`
cd ${WORKDIR}


set +u
set -ex


# Add csit scripts to PATH
export PATH=${PATH}:${WORKSPACE}/test/csit/docker/scripts:${WORKSPACE}/test/csit/scripts
export SCRIPTS=${WORKSPACE}/test/csit/scripts
export ROBOT_VARIABLES=

# Run setup script plan if it exists
cd ${TESTPLANDIR}
SETUP=${TESTPLANDIR}/setup.sh
if [ -f ${SETUP} ]; then
    echo "Running setup script ${SETUP}"
    source ${SETUP}
fi

# Run test plan
cd $WORKDIR
echo "Reading the testplan:"
cat ${TESTPLANDIR}/testplan.txt | egrep -v '(^[[:space:]]*#|^[[:space:]]*$)' | sed "s|^|${WORKSPACE}/test/csit/tests/|" > testplan.txt.tmp
cat testplan.txt.tmp
SUITES=$( xargs -a testplan.txt.tmp )

echo ROBOT_VARIABLES=${ROBOT_VARIABLES}
echo "Starting Robot test suites ${SUITES} ..."

cp ${WORKSPACE}/test/csit/tests/sdno-ipsec/provision/huawei_*.json ${WORKDIR}

pybot -N ${TESTPLAN} -v WORKSPACE:/tmp ${ROBOT_VARIABLES} ${TESTOPTIONS} ${SUITES} || true

# Run teardown script plan if it exists
cd ${TESTPLANDIR}
TEARDOWN=${TESTPLANDIR}/teardown.sh
if [ -f ${TEARDOWN} ]; then
    echo "Running teardown script ${TEARDOWN}"
    source ${TEARDOWN}
fi

# TODO: do something with the output

