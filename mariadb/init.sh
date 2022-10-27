#!/bin/sh

echo "Starting temporary server!"
mariadbd --user=root &

sleep 5

echo "Securing the MYSQL installation!"
mysql --user=root << _EOF_
	ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOT_PASSWORD';
	DELETE FROM mysql.user WHERE User='';
	DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
	DROP DATABASE IF EXISTS test;
	DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
	FLUSH PRIVILEGES;
_EOF_
echo "MYSQL installation secured!"

sleep 3

echo "Stopping temporary server!"
mysqladmin --user=root --password=$MARIADB_ROOT_PASSWORD shutdown
