# Configure MSB IP address
MSB_IP=`echo $MSB_ADDR | cut -d: -f 1`
MSB_PORT=`echo $MSB_ADDR | cut -d: -f 2`
sed -i "s|MSB_SERVICE_IP.*|MSB_SERVICE_IP = '$MSB_IP'|" vio/vio/pub/config/config.py
sed -i "s|MSB_SERVICE_PORT.*|MSB_SERVICE_PORT = '$MSB_PORT'|" vio/vio/pub/config/config.py
sed -i "s|DB_NAME.*|DB_NAME = 'inventory'|" vio/vio/pub/config/config.py
sed -i "s|DB_USER.*|DB_USER = 'inventory'|" vio/vio/pub/config/config.py
sed -i "s|DB_PASSWD.*|DB_PASSWD = 'inventory'|" vio/vio/pub/config/config.py
sed -i "s|\"ip\": \".*\"|\"ip\": \"$SERVICE_IP\"|" vio/vio/pub/config/config.py

# Configure MYSQL
if [ -z "$MYSQL_ADDR" ]; then
    export MYSQL_IP=`hostname -i`
    export MYSQL_PORT=3306
    export MYSQL_ADDR=$MYSQL_IP:$MYSQL_PORT
else
    MYSQL_IP=`echo $MYSQL_ADDR | cut -d: -f 1`
    MYSQL_PORT=`echo $MYSQL_ADDR | cut -d: -f 2`
fi
echo "MYSQL_ADDR=$MYSQL_ADDR"
sed -i "s|DB_IP.*|DB_IP = '$MYSQL_IP'|" vio/vio/pub/config/config.py
sed -i "s|DB_PORT.*|DB_PORT = $MYSQL_PORT|" vio/vio/pub/config/config.py

cat vio/vio/pub/config/config.py

sed -i "s|127\.0\.0\.1|$SERVICE_IP|" vio/run.sh
sed -i "s|127\.0\.0\.1|$SERVICE_IP|" vio/stop.sh
