#!/bin/sh

VERSION='1.0.0-SNAPSHOT'

# autorelease root dir
ROOT=`git rev-parse --show-toplevel`/autorelease

# Directory containing all repos
BUILD_DIR=$ROOT/build
mkdir -p $BUILD_DIR
cd $BUILD_DIR

# All binaries should have already been generated in their respective repos
DIST_DIR=$BUILD_DIR/integration/distribution/target
rm -rf $DIST_DIR
mkdir -p $DIST_DIR
cd $DIST_DIR

files="
./common-services-microservice-bus/msb-core/distributions/standalone/target/version/msb-standalone-1.0.0-SNAPSHOT-linux64.tar.gz
./common-tosca-model-designer/modeldesigner/distribution/modeldesigner-standalone/target/version/modeldesigner-standalone-1.0.0-SNAPSHOT-linux.gtk.x86_64.tar.gz
./common-services-auth/deployment/target/deployoutput/AuthService-.1.0.0-SNAPSHOT.zip
./common-services-common-utilities/wso2bpel-ext/wso2bpel-core/distribution/standalone/target/openo-commonservice-commonutilities-1.0.0-SNAPSHOT.zip
./common-services-driver-mgr/deployment/target/deployoutput/DriverManagerService-.1.0.0-SNAPSHOT.zip
./common-services-external-system-registration/extsys-core/distribution/standalone/target/openo-commonservice-extsys-1.0.0-SNAPSHOT.zip
./common-services-microservice-bus/msb-core/distributions/standalone/target/version/msb-standalone-1.0.0-SNAPSHOT-win64.zip
./common-tosca-catalog/catalog-core/distribution/catalog-standalone/target/openo-catalog-1.0.0-SNAPSHOT.zip
./common-tosca-inventory/inventory-core/distribution/standalone/target/openo-commontosca-inventory-1.0.0-SNAPSHOT.zip
./common-tosca-model-designer/modeldesigner/distribution/modeldesigner-standalone/target/version/modeldesigner-standalone-1.0.0-SNAPSHOT.zip
./gso/gso_commsvc_svcmgr_service/deployment/target/deployoutput/ServiceManagerService-1.0.0.20160915112634.zip
./gso-gui/servicegateway/deployment/target/deployoutput/deployment-1.0.0.20160915112623.zip
./nfvo/drivers/vnfm/svnfm/etsi-ia/etsiia-standalone/target/openo-etsiia-0.0.1-SNAPSHOT.zip
./nfvo/monitor/dac/dac-api/microservice-standalone/target/openo-dac-0.0.1-SNAPSHOT.zip
./nfvo/monitor/umc/umc-api/microservice-standalone/target/openo-umc-0.0.1-SNAPSHOT.zip
./sdno-driver-huawei-l3vpn/deployment/target/deployoutput/l3vpndriver-service.0.0.1-SNAPSHOT.zip
./sdno-driver-huawei-openstack/deployment/target/deployoutput/osdriverservice.0.0.1-SNAPSHOT.zip
./sdno-driver-huawei-overlay/deployment/target/deployoutput/org.openo.sdno.overlayvpndriver.0.0.1-SNAPSHOT.zip
./sdno-driver-huawei-servicechain/deployment/target/deployoutput/servicechaindriverservice-0.0.1-SNAPSHOT.zip
./sdno-ipsec/deployment/target/deployoutput/ipsecservice-0.0.1-SNAPSHOT.zip
./sdno-l2vpn/deployment/target/deployoutput/l2vpnservice-0.0.1-SNAPSHOT.zip
./sdno-l3vpn/deployment/target/deployoutput/l3vpnservice-0.0.1-SNAPSHOT.zip
./sdno-nslcm/deployment/target/deployoutput/nslcmservice-0.0.1-SNAPSHOT.zip
./sdno-overlay/deployment/target/deployoutput/overlayvpnservice-0.0.1-SNAPSHOT.zip
./sdno-servicechain/deployment/target/deployoutput/servicechainservice-0.0.1-SNAPSHOT.zip
./sdno-vpc/deployment/target/deployoutput/vpcservice-0.0.1-SNAPSHOT.zip
./sdno-vxlan/deployment/target/deployoutput/vxlanservice-0.0.1-SNAPSHOT.zip
"

for file in $files; do
    cp $BUILD_DIR/$file $DIST_DIR
done

ls -1 $DIST_DIR
