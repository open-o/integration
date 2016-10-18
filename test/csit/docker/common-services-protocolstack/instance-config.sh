# Initialize DB schema
MSB_IP=`echo $MSB_ADDR | cut -d: -f 1`
sed -i "s|msb\.openo\.org|${MSB_IP}|" etc/conf/restclient.json
cat etc/conf/restclient.json
