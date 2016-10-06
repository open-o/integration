# missing executable permissions
chmod +x bin/*.sh
# JasperListener is not available on Tomcat 8
sed -i 's|<Listener className="org.apache.catalina.core.JasperListener" />|<!-- NOT AVAILABLE IN TOMCAT 8 <Listener className="org.apache.catalina.core.JasperListener" /> -->|' conf/server.xml
