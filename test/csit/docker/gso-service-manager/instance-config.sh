# Initialize DB schema
# TODO: using "test" database for now, need to change to use correct database
mysql -uroot test < /service/init/servicemanagerservice_tables_mysql.sql
