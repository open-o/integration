README: Script usage
====================

I. Import Data to ESR and BRS
---

### I.1 import_data_to_esr_brs.pl/import_data_to_esr_brs.sh
A script for registering network controllers to External System Resistration (ESR) and populating network devices (managed elements) into BRS.
It first registers network controllers to ESR and remembers controller id returned by ESR.
It then creates site in BRS and remember site id (uuid) returned by BRS.
After that, these controller ids and site id will be inserted into corresponding managed-element's meta data.
Finally, managed elements with correct controller id and site id will be created in BRS.

### I.2 Controllers.json
One sample of network controller meta-data
It should be changed based on the network scenario to be tested.

### I.3 Site.json
One sample of site meta-data
It should be changed based on the network scenario to be tested.

### I.4 ManagedElements.json
One sample of managed element meta-data
It should be changed based on the network scenario to be tested.

### I.5 Usage
`import_data_to_esr_brs.pl <MSB_ADDR[ipv4:port]> <CONTROLLERS_SIMULATOR_IP[ipv4]> <CONTROLLERS_FILE_NAME[json]> SITE_FILE_NAME[json]> <MANAGED_ELEMENTS_FILE_NAME[json]>`
`import_data_to_esr_brs.sh <MSB_ADDR[ipv4:port]> <CONTROLLERS_SIMULATOR_IP[ipv4]> <CONTROLLERS_FILE_NAME[json]> SITE_FILE_NAME[json]> <MANAGED_ELEMENTS_FILE_NAME[json]>`