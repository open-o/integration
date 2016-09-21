#!/bin/bash

DATADIR="/var/lib/mysql"
	
if [ ! -d "$DATADIR/mysql" ]; then
    echo 'Running mysql_install_db ...'
    su mysql -c "mysql_install_db --datadir=$DATADIR"
    echo 'Finished mysql_install_db'
fi
    
su mysql -c /usr/bin/mysqld_safe

