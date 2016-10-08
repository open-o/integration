# Set mysql root password
sed -i 's|Test_12345|rootpass|' ./webapps/vnfmadapter-service/WEB-INF/classes/spring/Vnfmadapter/services.xml

# Initialize MySQL schema
cd bin
./init_db.sh root rootpass 127.0.0.1 3306
