#!/bin/bash
# $1 nickname for the CATALOG instance
# $2 IP address of MSB

run-instance.sh common-tosca-catalog $1 "-e MSB_ADDR=$2"
