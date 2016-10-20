# Initialize DB schema
./initDB.sh root rootpass 3306 127.0.0.1

# Set mysql username/password
sed -i "s|user:.*|user: root|" conf/config.yaml
sed -i "s|password:.*|password: rootpass|" conf/config.yaml
cat conf/config.yaml
