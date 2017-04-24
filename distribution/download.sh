
#!/bin/bash
#
# Copyright 2016-2017 Huawei Technologies Co., Ltd.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

VERSION=2.0.0

set +e


# Open-O Command-Line interface (CLI)
mkdir -p client-cli
wget -O "client-cli/client-cli-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.client.cli&a=client-cli-deployment&e=zip&c=&v=$VERSION"

# Open-O GUI
mkdir -p client-gui
wget -O "client-gui/client-gui-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.client.gui&a=integration&e=zip&c=&v=$VERSION"

# Common Services Authentication
mkdir -p common-services-auth
wget -O "common-services-auth/common-services-auth-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.common-services.auth&a=auth-service-deployment&e=zip&c=&v=$VERSION"

# Common Services WSO2 Extension
mkdir -p common-services-wso2ext
wget -O "common-services-wso2ext/common-services-wso2ext-$VERSION.linux64.tar.gz" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.common-services.common-utilities.wso2bpel-ext&a=standalone&e=tar.gz&c=linux64&v=$VERSION"

# Common Services Driver Manager
mkdir -p common-services-drivermanager
wget -O "common-services-drivermanager/common-services-drivermanager-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.common-services.driver-mgr&a=drivermanager-service-deployment&e=zip&c=&v=$VERSION"

# Common Services External System Register
mkdir -p common-services-extsys
wget -O "common-services-extsys/common-services-extsys-$VERSION.linux64.tar.gz" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.common-services.external-system-registration&a=standalone&e=tar.gz&c=linux64&v=$VERSION"

# Common Services Microservice Bus
mkdir -p common-services-msb
wget -O "common-services-msb/common-services-msb-$VERSION.linux64.tar.gz" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.common-services.microservice-bus&a=msb-core-standalone&e=tar.gz&c=linux64&v=$VERSION"

# Common Services Protocol Stack
mkdir -p common-services-protocolstack
wget -O "common-services-protocolstack/common-services-protocolstack-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.common-services.protocol-stack&a=protocolstackservice-deployment&e=zip&c=&v=$VERSION"

# Common TOSCA ARIA
mkdir -p common-tosca-aria
wget -O "common-tosca-aria/common-tosca-aria-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.common-tosca.aria&a=aria&e=zip&c=&v=$VERSION"

# Common TOSCA Catalog
mkdir -p common-tosca-catalog
wget -O "common-tosca-catalog/common-tosca-catalog-$VERSION.linux64.tar.gz" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.common-tosca.catalog&a=catalog-all&e=tar.gz&c=linux64&v=$VERSION"

# Common TOSCA Inventory
mkdir -p common-tosca-inventory
wget -O "common-tosca-inventory/common-tosca-inventory-$VERSION.bin.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.common-tosca.inventory&a=inventory-standalone&e=zip&c=bin&v=$VERSION"

# Common TOSCA Model Designer
mkdir -p common-tosca-modeldesigner
wget -O "common-tosca-modeldesigner/common-tosca-modeldesigner-$VERSION.linux.gtk.x86_64.tar.gz" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.common-tosca.model-designer.modeldesigner.distribution&a=modeldesigner-standalone&e=tar.gz&c=linux.gtk.x86_64&v=$VERSION"

# GSO Service Gateway
mkdir -p gso-service-gateway
wget -O "gso-service-gateway/gso-service-gateway-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.gso&a=service-gateway-deployment&e=zip&c=&v=$VERSION"

# GSO Service Manager
mkdir -p gso-service-manager
wget -O "gso-service-manager/gso-service-manager-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.gso&a=servicemanagerservice-deployment&e=zip&c=&v=$VERSION"

# GVNFM Lifecycle Management
mkdir -p gvnfm-vnflcm
wget -O "gvnfm-vnflcm/gvnfm-vnflcm-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.gvnfm.vnflcm&a=gvnfm-vnflcm&e=zip&c=&v=$VERSION"

# GVNFM Init Configuration and Management
mkdir -p gvnfm-vnfmgr
wget -O "gvnfm-vnfmgr/gvnfm-vnfmgr-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.gvnfm.vnfmgr&a=gvnfm-vnfmgr&e=zip&c=&v=$VERSION"

# GVNFM Virtual Resource Management
mkdir -p gvnfm-vnfres
wget -O "gvnfm-vnfres/gvnfm-vnfres-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.gvnfm.vnfres&a=gvnfm-vnfres&e=zip&c=&v=$VERSION"

# NFVO VIM Driver
mkdir -p nfvo-driver-vim
wget -O "nfvo-driver-vim/nfvo-driver-vim-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.nfvo&a=vimadapter-deployment&e=zip&c=&v=$VERSION"

# NFVO VNFM Driver GVNFM
mkdir -p nfvo-driver-vnfm-gvnfm
wget -O "nfvo-driver-vnfm-gvnfm/nfvo-driver-vnfm-gvnfm-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.nfvo&a=drivers-vnfm-gvnfm-gvnfmadapter&e=zip&c=&v=$VERSION"

# NFVO VNFM Driver Huawei
mkdir -p nfvo-driver-vnfm-huawei
wget -O "nfvo-driver-vnfm-huawei/nfvo-driver-vnfm-huawei-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.nfvo&a=hw-vnfmadapter-deployment&e=zip&c=&v=$VERSION"

# NFVO VNFM Driver JUJU
mkdir -p nfvo-driver-vnfm-juju
wget -O "nfvo-driver-vnfm-juju/nfvo-driver-vnfm-juju-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.nfvo&a=juju-vnfmadapterservice-deployment&e=zip&c=&v=$VERSION"

# NFVO VNFM Driver ZTE
mkdir -p nfvo-driver-vnfm-zte
wget -O "nfvo-driver-vnfm-zte/nfvo-driver-vnfm-zte-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.nfvo&a=drivers-vnfm-svnfm-zte-vmanager&e=zip&c=&v=$VERSION"

# NFVO VNFM Driver Ericsson
mkdir -p nfvo-driver-vnfm-ericsson
wget -O "nfvo-driver-vnfm-ericsson/nfvo-driver-vnfm-ericsson-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.nfvo&a=ericsson-vnfm-driver-deployment&e=zip&c=&v=$VERSION"

# NFVO Lifecycle Management
mkdir -p nfvo-lcm
wget -O "nfvo-lcm/nfvo-lcm-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.nfvo&a=nfvo-lcm&e=zip&c=&v=$VERSION"

# NFVO Resource Manager
mkdir -p nfvo-resmanagement
wget -O "nfvo-resmanagement/nfvo-resmanagement-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.nfvo&a=resmanagement-deployment&e=zip&c=&v=$VERSION"

# NFVO Monitor Data Acquire Component
mkdir -p nfvo-dac
wget -O "nfvo-dac/nfvo-dac-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.nfvo.monitor.dac.dac-api&a=dac-standalone&e=zip&c=&v=$VERSION"

# NFVO Monitor Unified Monitor Component
mkdir -p nfvo-umc
wget -O "nfvo-umc/nfvo-umc-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.nfvo.monitor.umc.umc-api&a=umc-standalone&e=zip&c=&v=$VERSION"

# NFVO SDNC Driver ZTE
mkdir -p nfvo-driver-sdnc-zte
wget -O "nfvo-driver-sdnc-zte/nfvo-driver-sdnc-zte-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.nfvo.sfc-driver-standalone&a=nfvo-drivers-sdnc-zte-sfc-driver&e=zip&c=&v=$VERSION"

# Policy Designer
mkdir -p policy-designer
wget -O "policy-designer/policy-designer-$VERSION.linux64.tar.gz" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.policy.designer&a=policydesigner-resource&e=tar.gz&c=linux64&v=$VERSION"

# Policy Engine
mkdir -p policy-engine
wget -O "policy-engine/policy-engine-$VERSION.linux64.tar.gz" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.policy.engine&a=policy-engine-core&e=tar.gz&c=linux64&v=$VERSION"

# Policy Lcm
mkdir -p policy-lcm
wget -O "policy-lcm/policy-lcm-$VERSION.linux64.tar.gz" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.policy.lcm&a=apply&e=tar.gz&c=linux64&v=$VERSION"

# SDNHUB Driver CT TE
mkdir -p sdnhub-driver-ct-te
wget -O "sdnhub-driver-ct-te/sdnhub-driver-ct-te-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.sdnhub.driver-ct-te&a=ct_tedriver&e=zip&c=&v=$VERSION"

# SDNHUB Driver Huawei L3VPN
mkdir -p sdnhub-driver-huawei-l3vpn
wget -O "sdnhub-driver-huawei-l3vpn/sdnhub-driver-huawei-l3vpn-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.sdnhub.driver-huawei-l3vpn&a=l3vpndriver-deployment&e=zip&c=&v=$VERSION"

# SDNHUB Driver Huawei Openstack
mkdir -p sdnhub-driver-huawei-openstack
wget -O "sdnhub-driver-huawei-openstack/sdnhub-driver-huawei-openstack-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.sdnhub.driver-huawei-openstack&a=osdriverservice-deployment&e=zip&c=&v=$VERSION"

# SDNHUB Driver Huawei Overlay
mkdir -p sdnhub-driver-huawei-overlay
wget -O "sdnhub-driver-huawei-overlay/sdnhub-driver-huawei-overlay-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.sdnhub.driver-huawei-overlay&a=overlayvpndriver-deployment&e=zip&c=&v=$VERSION"

# SDNHUB Driver Huawei Servicechain
mkdir -p sdnhub-driver-huawei-servicechain
wget -O "sdnhub-driver-huawei-servicechain/sdnhub-driver-huawei-servicechain-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.sdnhub.driver-huawei-servicechain&a=servicechaindriverservice-deployment&e=zip&c=&v=$VERSION"

# SDNHUB Driver ZTE SPTN
mkdir -p sdnhub-driver-zte-sptn
wget -O "sdnhub-driver-zte-sptn/sdnhub-driver-zte-sptn-$VERSION.linux64.tar.gz" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.sdnhub.driver-zte-sptn&a=standalone&e=tar.gz&c=linux64&v=$VERSION"

# SDNO Services BRS
mkdir -p sdno-service-brs
wget -O "sdno-service-brs/sdno-service-brs-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.sdno.brs&a=brs-deployment&e=zip&c=&v=$VERSION"

# SDNO Services MSS
mkdir -p sdno-service-mss
wget -O "sdno-service-mss/sdno-service-mss-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.sdno.brs&a=mss-deployment&e=zip&c=&v=$VERSION"

# SDNO Services IpSec
mkdir -p sdno-service-ipsec
wget -O "sdno-service-ipsec/sdno-service-ipsec-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.sdno.ipsec&a=ipsecservice-deployment&e=zip&c=&v=$VERSION"

# SDNO Services L2VPN
mkdir -p sdno-service-l2vpn
wget -O "sdno-service-l2vpn/sdno-service-l2vpn-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.sdno.l2vpn&a=l2vpnservice-deployment&e=zip&c=&v=$VERSION"

# SDNO Services L3VPN
mkdir -p sdno-service-l3vpn
wget -O "sdno-service-l3vpn/sdno-service-l3vpn-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.sdno.l3vpn&a=l3vpnservice-deployment&e=zip&c=&v=$VERSION"

# SDNO Services LCM
mkdir -p sdno-service-lcm
wget -O "sdno-service-lcm/sdno-service-lcm-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.sdno.lcm&a=lcm-deployment&e=zip&c=&v=$VERSION"

# SDNO Monitoring
mkdir -p sdno-monitoring
wget -O "sdno-monitoring/sdno-monitoring-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.sdno.monitoring&a=ct_monitoring&e=zip&c=&v=$VERSION"

# SDNO Services Nslcm
mkdir -p sdno-service-nslcm
wget -O "sdno-service-nslcm/sdno-service-nslcm-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.sdno.nslcm&a=nslcm-deployment&e=zip&c=&v=$VERSION"

# SDNO Optimize
mkdir -p sdno-optimize
wget -O "sdno-optimize/sdno-optimize-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.sdno.optimize&a=ct_optimizer&e=zip&c=&v=$VERSION"

# SDNO Services Overlay VPN
mkdir -p sdno-service-overlayvpn
wget -O "sdno-service-overlayvpn/sdno-service-overlayvpn-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.sdno.overlay&a=overlayvpnservice-deployment&e=zip&c=&v=$VERSION"

# SDNO Services Route
mkdir -p sdno-service-route
wget -O "sdno-service-route/sdno-service-route-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.sdno.route&a=routeservice-deployment&e=zip&c=&v=$VERSION"

# SDNO Services Service Chain
mkdir -p sdno-service-servicechain
wget -O "sdno-service-servicechain/sdno-service-servicechain-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.sdno.servicechain&a=servicechainservice-deployment&e=zip&c=&v=$VERSION"

# SDNO Services Site
mkdir -p sdno-service-site
wget -O "sdno-service-site/sdno-service-site-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.sdno.site&a=localsiteservice-deployment&e=zip&c=&v=$VERSION"

# SDNO Services VPC
mkdir -p sdno-service-vpc
wget -O "sdno-service-vpc/sdno-service-vpc-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.sdno.vpc&a=vpcservice-deployment&e=zip&c=&v=$VERSION"

# SDNO Vsite Manager
mkdir -p sdno-vsitemgr
wget -O "sdno-vsitemgr/sdno-vsitemgr-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.sdno.vsitemgr&a=ct_vsitemgr&e=zip&c=&v=$VERSION"

# SDNO Services VxLAN
mkdir -p sdno-service-vxlan
wget -O "sdno-service-vxlan/sdno-service-vxlan-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.sdno.vxlan&a=vxlanservice-deployment&e=zip&c=&v=$VERSION"

# VNF SDK Function Test
mkdir -p vnfsdk-function-test
wget -O "vnfsdk-function-test/vnfsdk-function-test-$VERSION.linux64.tar.gz" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.vnf-sdk.function-test&a=standalone&e=tar.gz&c=linux64&v=$VERSION"

# VNF SDK Marketplace
mkdir -p vnf-sdk-marketplace
wget -O "vnf-sdk-marketplace/vnf-sdk-marketplace-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.vnf-sdk.marketplace&a=vnf-sdk-marketplace-deployment&e=zip&c=&v=$VERSION"

# VNF SDK Validate Lifecycle Test
mkdir -p vnf-sdk-validate-lc-test
wget -O "vnf-sdk-validate-lc-test/vnf-sdk-validate-lc-test-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.vnf-sdk.validate-lc-test&a=lifecycle-test-deployment&e=zip&c=&v=$VERSION"

# MultiVIM broker
mkdir -p multivim-broker
wget -O "multivim-broker/multivim-broker-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.multivimdriver.broker&a=multivimbroker&e=zip&c=&v=$VERSION"

# MultiVIM driver of OpenStack Newton
mkdir -p multivim-driver-newton
wget -O "multivim-driver-newton/multivim-driver-newton-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.multivimdriver.openstack&a=multivimdriver-openstack-newton&e=zip&c=&v=$VERSION"

# MultiVIM driver of OpenStack Kilo
mkdir -p multivim-driver-kilo
wget -O "multivim-driver-kilo/multivim-driver-kilo-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.multivimdriver.openstack&a=multivimdriver-openstack-kilo&e=zip&c=&v=$VERSION"

# MultiVIM driver of VMware VIO
mkdir -p multivim-driver-vio
wget -O "multivim-driver-vio/multivim-driver-vio-$VERSION.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.multivimdriver.vmware.vio&a=multivimdriver-vio&e=zip&c=&v=$VERSION"

# Holmes Engine D
mkdir -p holmes-engine-d-standalone
wget -O "holmes-engine-d-standalone/holmes-engine-d-standalone-$VERSION.linux64.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.holmes.engine-management&a=holmes-engine-d-standalone&e=zip&c=linux64&v=$VERSION"

# Holmes Rulemgt Standalone
mkdir -p holmes-rulemgt-standalone
wget -O "holmes-rulemgt-standalone/holmes-rulemgt-standalone-$VERSION.linux64.zip" "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=releases&g=org.openo.holmes.rule-management&a=holmes-rulemgt-standalone&e=zip&c=linux64&v=$VERSION"

