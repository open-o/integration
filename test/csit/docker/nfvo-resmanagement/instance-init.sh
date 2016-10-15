# Set mysql root password
sed -i 's|123456|rootpass|' ./webapps/ROOT/WEB-INF/classes/spring/Resmanagement/services.xml

# Initialize MySQL schema
cd bin
./init_db.sh root rootpass 127.0.0.1 3306
