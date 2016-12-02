# This script is sourced by run-csit.sh after Robot test completion.

kill-instance.sh d-driver-huawei-openstack
kill-instance.sh d-driver-huawei-overlay
kill-instance.sh s-ipsec
kill-instance.sh i-common-services-extsys
kill-instance.sh d-drivermgr
kill-instance.sh i-brs
kill-instance.sh i-mss
kill-instance.sh i-msb
kill  `ps -ax | grep java| grep moco | awk '{print $1}'`