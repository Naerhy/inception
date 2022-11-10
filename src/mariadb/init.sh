#!/bin/sh

echo "Starting temporary server..."
mariadbd --user=root &

sleep 3

echo "Creating Wordpress database..."
mysql --user=root << _EOF_
	CREATE DATABASE $MARIADB_DATABASE;
	CREATE USER '$MARIADB_LOGIN'@'%' IDENTIFIED BY '$MARIADB_PASSWORD';
	GRANT ALL ON $MARIADB_DATABASE.* TO '$MARIADB_LOGIN'@'%';
	FLUSH PRIVILEGES;
_EOF_
echo "Wordpress database created!"

echo "Securing the MYSQL installation..."
mysql --user=root << _EOF_
	ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOT_PASSWORD';
	DELETE FROM mysql.user WHERE User='';
	DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
	DROP DATABASE IF EXISTS test;
	DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
	FLUSH PRIVILEGES;
_EOF_
echo "MYSQL installation secured!"

echo "Stopping temporary server!"
mysqladmin --user=root --password=$MARIADB_ROOT_PASSWORD shutdown

sleep 3

echo "Starting mariadb server..."
exec mariadbd --user=root
