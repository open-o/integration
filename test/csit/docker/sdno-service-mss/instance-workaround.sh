#!/bin/bash

# workaround for mysqld start randomly failed at "io_setup() failed"
sed -i '/\[mysqld\]/a innodb_use_native_aio=0' /etc/my.cnf

# mss currently hard-coded password as root
sed -i 's/rootpass/root/g' /service/init-mysql.sh
# mss-init setup db and tables from models xml-files
echo "/service/bin/initdb.sh" >> /service/init-mysql.sh

# make catalina.sh found
sed -i '/#!\/bin\/bash/a export PATH=$PATH:/service/bin' /service/bin/{start.sh,stop.sh}
# workaround for tomcat blocked by VM always short of entropy
sed -i '/#!\/bin\/bash/a export JAVA_OPTS="$JAVA_OPTS -Djava.security.egd=file:/dev/./urandom"' /service/bin/start.sh

# code stick to 127.0.0.1:8080, socat proxy it to actual MSB
sed -i 's/"msb.openo.org"/"127.0.0.1"/g;s/"port":"80"/"port":"8080"/g' /service/etc/conf/restclient.json

# replace empty ip address with service ip, provided from command line while running docker
sed -i "s/\"ip\": \"\"/\"ip\": \"$SERVICE_IP\"/g" /service/generalconfig/msbRegistion.json

# done
