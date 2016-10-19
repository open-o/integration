# Set MSB address
sed -i "s|msb\.address=.*|msb.address=$MSB_ADDR|" etc/microservice.ini
cat etc/microservice.ini

sed -i "s|10\.229\.47\.199|$SERVICE_IP|" etc/microservice/auth_rest.json
cat etc/microservice/auth_rest.json

