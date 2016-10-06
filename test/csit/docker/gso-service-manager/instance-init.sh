# Initialize DB schema
mysql -uroot -prootpass < /service/init/servicemanagerservice_tables_mysql.sql

sed -i 's|name="password" value=""|name="password" value="rootpass"|' webapps/ROOT/WEB-INF/classes/spring/service.xml
