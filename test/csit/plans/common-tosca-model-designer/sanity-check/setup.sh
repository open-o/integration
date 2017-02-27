# This script is sourced by run-csit.sh before the Robot tests are run.
kill-instance.sh modeldesigner

${SCRIPTS}/common-tosca-model-designer/startup.sh
MODELDESIGNER_IP=`get-instance-ip.sh modeldesigner`
echo MODELDESIGNER_IP=${MODELDESIGNER_IP}

