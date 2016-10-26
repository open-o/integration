# Run microservice
source env/bin/activate
open-o-common-tosca-parser-service start --rundir log
tail -F log/open-o-common-tosca-parser-service.log
