# OPEN-O Mercury Release 2.0.0

## Download

Run download.sh to retrieve all the OPEN-O microservice binaries.  Each binary
will be placed in its own subdirectory.

## Microservices List

Open-O contains the following microservices:

  * client-cli                             Open-O Command-Line interface (CLI)
  * client-gui                             Open-O GUI
  * common-services-auth                   Common Services Authentication
  * common-services-drivermanager          Common Services Driver Manager
  * common-services-extsys                 Common Services External System Register
  * common-services-msb                    Common Services Microservice Bus
  * common-services-protocolstack          Common Services Protocol Stack
  * common-services-wso2ext                Common Services WSO2 Extension
  * common-tosca-aria                      Common TOSCA ARIA
  * common-tosca-catalog                   Common TOSCA Catalog
  * common-tosca-inventory                 Common TOSCA Inventory
  * common-tosca-modeldesigner             Common TOSCA Model Designer
  * gso-service-gateway                    GSO Service Gateway
  * gso-service-manager                    GSO Service Manager
  * gvnfm-vnflcm                           GVNFM Lifecycle Management
  * gvnfm-vnfmgr                           GVNFM Init Configuration and Management
  * gvnfm-vnfres                           GVNFM Virtual Resource Management
  * holmes-engine-d-standalone             Holmes Engine D
  * holmes-rulemgt-standalone              Holmes Rulemgt Standalone
  * multivim-broker                        MultiVIM broker
  * multivim-driver-kilo                   MultiVIM driver of OpenStack Kilo
  * multivim-driver-newton                 MultiVIM driver of OpenStack Newton
  * multivim-driver-vio                    MultiVIM driver of VMware VIO
  * nfvo-dac                               NFVO Monitor Data Acquire Component
  * nfvo-driver-sdnc-zte                   NFVO SDNC Driver ZTE
  * nfvo-driver-vim                        NFVO VIM Driver
  * nfvo-driver-vnfm-ericsson              NFVO VNFM Driver Ericsson
  * nfvo-driver-vnfm-gvnfm                 NFVO VNFM Driver GVNFM
  * nfvo-driver-vnfm-huawei                NFVO VNFM Driver Huawei
  * nfvo-driver-vnfm-juju                  NFVO VNFM Driver JUJU
  * nfvo-driver-vnfm-zte                   NFVO VNFM Driver ZTE
  * nfvo-lcm                               NFVO Lifecycle Management
  * nfvo-resmanagement                     NFVO Resource Manager
  * nfvo-umc                               NFVO Monitor Unified Monitor Component
  * policy-designer                        Policy Designer
  * policy-engine                          Policy Engine
  * policy-lcm                             Policy Lcm
  * sdnhub-driver-ct-te                    SDNHUB Driver CT TE
  * sdnhub-driver-huawei-l3vpn             SDNHUB Driver Huawei L3VPN
  * sdnhub-driver-huawei-openstack         SDNHUB Driver Huawei Openstack
  * sdnhub-driver-huawei-overlay           SDNHUB Driver Huawei Overlay
  * sdnhub-driver-huawei-servicechain      SDNHUB Driver Huawei Servicechain
  * sdnhub-driver-zte-sptn                 SDNHUB Driver ZTE SPTN
  * sdno-monitoring                        SDNO Monitoring
  * sdno-optimize                          SDNO Optimize
  * sdno-service-brs                       SDNO Services BRS
  * sdno-service-ipsec                     SDNO Services IpSec
  * sdno-service-l2vpn                     SDNO Services L2VPN
  * sdno-service-l3vpn                     SDNO Services L3VPN
  * sdno-service-lcm                       SDNO Services LCM
  * sdno-service-mss                       SDNO Services MSS
  * sdno-service-nslcm                     SDNO Services Nslcm
  * sdno-service-overlayvpn                SDNO Services Overlay VPN
  * sdno-service-route                     SDNO Services Route
  * sdno-service-servicechain              SDNO Services Service Chain
  * sdno-service-site                      SDNO Services Site
  * sdno-service-vpc                       SDNO Services VPC
  * sdno-service-vxlan                     SDNO Services VxLAN
  * sdno-vsitemgr                          SDNO Vsite Manager
  * vnfsdk-function-test                   VNF SDK Function Test
  * vnf-sdk-marketplace                    VNF SDK Marketplace
  * vnf-sdk-validate-lc-test               VNF SDK Validate Lifecycle Test

See [Installation Instructions][0] for details on how to install and run each microservice.

See [OPEN-O Sun Release Notes][1] for the release notes about this release.

[0]: https://wiki.open-o.org/view/Installation_Instructions
[1]: https://wiki.open-o.org/display/REL/OPEN-O+Mercury+Release+Notes
