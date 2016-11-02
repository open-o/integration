# Set tomcat port
sed -i 's|Connector port="8080"|Connector port="8300"|' conf/server.xml
