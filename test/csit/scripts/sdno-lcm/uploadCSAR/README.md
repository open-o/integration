README: Script usage
====================

I. Upload CSAR files
---

### I.1 uploadCSAR.sh
A script to upload csar files to tosca calatog and aria

### I.2 enterprise2DC/underlayVPN csar 
Sample csar file. 

### I.3 Usage
`uploadCSAR.sh <MSB_ADDR[ipv4:port]> <CSAR_DIR> <CSAR_FILENAME:default[enterprise2DC.csar]>`
where:
* `MSB_ADDR`: is MSB address and this is mandatory field
* `CSAR_DIR`: is the location were the `csar` files lives. This is mandatory field.
* `CSAR_FILENAME`: this is an optional value. Default it will take `enterprise2DC.csar` as value. The script will check if that `csar` file is a file or not. In this case the script will exit with error code 1.