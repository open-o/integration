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

#Pull openoint/sdnhub-driver-ct-te
docker pull openoint/sdnhub-driver-ct-te

#Pull openoint/sdno-ipsec
docker pull openoint/sdno-ipsec

#Pull openoint/sdno-l2vpn
docker pull openoint/sdno-l2vpn

#Pull openoint/sdno-l3vpn
docker pull openoint/sdno-l3vpn

#Pull openoint/sdno-lcm
docker pull openoint/sdno-lcm

#Pull openoint/sdno-monitoring
docker pull openoint/sdno-monitoring

#Pull openoint/sdno-nslcm
docker pull openoint/sdno-nslcm

#Pull openoint/sdno-optimize
docker pull openoint/sdno-optimize

#Pull openoint/sdno-overlay
docker pull openoint/sdno-overlay

#Pull openoint/sdno-route
docker pull openoint/sdno-route

#Pull openoint/sdno-servicechain
docker pull openoint/sdno-servicechain

#Pull openoint/sdno-site
docker pull openoint/sdno-site

#Pull openoint/sdno-vpc
docker pull openoint/sdno-vpc

#Pull openoint/sdno-vsitemgr
docker pull openoint/sdno-vsitemgr

#Pull openoint/sdno-vxlan
docker pull openoint/sdno-vxlan