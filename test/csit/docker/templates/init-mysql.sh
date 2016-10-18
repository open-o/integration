# Wait for mysql to initialize; Set mysql root password
echo Initializing mysql
for i in {1..10}; do
    /usr/bin/mysqladmin -u root password 'rootpass' &> /dev/null && break
    sleep $i
done
