#!/bin/bash
# $1 nickname for the extsys instance
# $2 IP address of MSB

run-instance.sh openoint/common-services-extsys $1 "-e MSB_ADDR=$2"
