README: Script usage
====================

I. SERVICE CREATION
---

### I.1 create-ns.pl/create-ns.sh
A script used to create one service instance by calling sdno-lcm.
It will print out the id of the service instance created by sdno-lcm.
Caller should capture this output and use it to judge whether the creation is done successfully (uuid or not?).
The service id is also needed when instantiating this service instance.
These scripts(** Perl ** or ** Shell **) require the `CSEAR_ID` as input. The `CSEAR_ID` usally returned whenever an upload action of csar files to `csar-catalog ` is performed.

### I.2 Creation.json
One sample of the request body (service creation request).
The `nsdId` should be changed based on the template used in the test.

### I.3 Creation_underlay.json
One sample request for underlay

### I.4 Usage
`create-ns.pl <MSB_ADDR[ipv4:port]> <JSON_FILE_NAME> <CSAR_ID[uuid]>`
`create-ns.sh <MSB_ADDR[ipv4:port]> <JSON_FILE_NAME> <CSAR_ID[uuid]>`

II. SERVICE INSTANTIATION
---

### II.1 instantiate-ns.pl/instantiate-ns.sh:
A script used to instantiate one service instance by calling sdno-lcm
It will print out "jobId" that should be used by the caller to track instantiation progress.
Since SDN-O is currently implemented as synchronous call, service instance should have been instantiated successfully
when this call returns. "jobId" may be used to judge whether the instantiation is done successfully (uuid or not?).

### II.2 Instantiation.json:
One sample of the request body (service instantiation request)
IP addresses in this file should be same with the IP addresses of managed elements imported into BRS.
Other fields may also need to be changed based on the test scenario, especially the information shared with NFV-O.

### II.3 Instantiation_underlay.json:
One sample request for underlay

### II.4 Usage
`instantiate-ns.pl <MSB_ADDR[ipv4:port]> <INSTANCE_ID[uuid]> <JSON_FILE_NAME>`
`instantiate-ns.sh <MSB_ADDR[ipv4:port]> <INSTANCE_ID[uuid]> <JSON_FILE_NAME>`
