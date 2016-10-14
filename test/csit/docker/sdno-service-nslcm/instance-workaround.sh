#!/bin/bash

# make catalina.sh found
sed -i '/#!\/bin\/bash/a export PATH=$PATH:/service/bin' /service/bin/{start.sh,stop.sh}
# workaround for tomcat blocked by VM always short of entropy
sed -i '/#!\/bin\/bash/a export JAVA_OPTS="$JAVA_OPTS -Djava.security.egd=file:/dev/./urandom"' /service/bin/start.sh

# code stick to 127.0.0.1:8080, socat proxy it to actual MSB
sed -i 's/"msb.openo.org"/"127.0.0.1"/g;s/"port":"80"/"port":"8080"/g' /service/etc/conf/restclient.json

# done
