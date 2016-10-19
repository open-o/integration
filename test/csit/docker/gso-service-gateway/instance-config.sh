# Initialize DB schema
MSB_IP=`echo $MSB_ADDR | cut -d: -f 1`
sed -i "s|msb\.openo\.org|${MSB_IP}|" etc/conf/restclient.json
cat etc/conf/restclient.json

# Set self IP
sed -i "s|getInputIP|$SERVICE_IP|" etc/register/service.json
cat etc/register/service.json
