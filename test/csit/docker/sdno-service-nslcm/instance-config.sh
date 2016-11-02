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
sed -i "s|\${jdbc\.host}\:\${jdbc.port}|$MYSQL_ADDR|" webapps/ROOT/WEB-INF/classes/spring/service.xml
cat webapps/ROOT/WEB-INF/classes/spring/service.xml
