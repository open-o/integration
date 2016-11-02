# Configure webapp deployment
if [ ! -e webapps/openoui ]; then
    unzip -q -u openo-portal.war -d webapps/openoui
fi

MSB_IP=`echo $MSB_ADDR | cut -d: -f 1`
MSB_PORT=`echo $MSB_ADDR | cut -d: -f 2`

sed -i "s|<hostIp>.*</hostIp>|<hostIp>http://$MSB_IP</hostIp>|g" webapps/openoui/WEB-INF/classes/portalConfig/msb_register.xml
sed -i "s|<hostPort>.*</hostPort>|<hostPort>$MSB_PORT</hostPort>|g" webapps/openoui/WEB-INF/classes/portalConfig/msb_register.xml
sed -i "s|<ip>.*</ip>|<ip>$SERVICE_IP</ip>|g" webapps/openoui/WEB-INF/classes/portalConfig/msb_register.xml
cat webapps/openoui/WEB-INF/classes/portalConfig/msb_register.xml
