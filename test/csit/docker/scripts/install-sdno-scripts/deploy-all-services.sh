#!/bin/bash

#Un-deploy and remove all dockers
./undeploy-all-services.sh

#Install MSB, EXTSYS, DM - Need to configure MSB address in docker file
./deploy-service.sh package-commsvc.json

#Install all sdno-services - Need to configure MSB address in docker file
./deploy-service.sh package-sdnosvc.json

#Install sdno-drivers - Need to configure MSB address in docker file
./deploy-service.sh package-sdnodrivers.json