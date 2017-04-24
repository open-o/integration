README: Script usage
====================

I. Terminate Service
---

### I.1 terminate_service.sh
A script to terminate network service.
the output of the script is the network service id as uuid if the opreation is successful or null if it is not. 
for more details about service state chech sdno-lcm/state/service_state.sh

### I.2 Usage
`terminate_service.sh <MSB_ADDR[ipv4:port]> <TERMINATION_DIR[where terminate.json could be found]> <NSINSTANCEID[uuid]>`