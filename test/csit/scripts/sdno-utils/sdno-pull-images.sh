#!/bin/bash

#Stop existent docker instances
docker rm -f `docker ps -a | grep -v CONTAINER | awk '{print $1}' `|| true

#Pull MSB
docker pull openoint/common-services-msb

#Pull MSS
docker pull openoint/sdno-service-mss

#Pull BRS
docker pull openoint/sdno-service-brs

#Pull openoint/common-services-extsys
dockerv openoint/common-services-extsys

#Pull openoint/common-services-drivermanager
docker pull openoint/common-services-drivermanager

#Pull openoint/sdno-driver-simul-l2vpn
docker pull openoint/sdno-driver-simul-l2vpn

#Pull openoint/sdno-driver-simul-l3vpn
docker pull openoint/sdno-driver-simul-l3vpn

#Pull openoint/sdno-driver-simul-sfc
docker pull openoint/sdno-driver-simul-sfc

#Pull openoint/sdno-driver-simul-overlay
docker pull openoint/sdno-driver-simul-overlay

#Pull openoint/sdno-service-nslcm
docker pull openoint/sdno-service-nslcm

#Pull openoint/sdno-service-vpc
docker pull openoint/sdno-service-vpc