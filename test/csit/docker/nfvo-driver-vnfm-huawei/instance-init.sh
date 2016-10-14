# Config mysql credentials
sed -i "s|Test_12345|rootpass|" webapps/ROOT/WEB-INF/classes/spring/Vnfmadapter/services.xml

# Initialize MySQL schema
cd bin
./init_db.sh root rootpass 127.0.0.1 3306
