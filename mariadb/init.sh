#!/bin/sh

echo "Starting temporary server!"
mariadbd --user=root &

sleep 5

echo "Creating Wordpress database!"
mysql --user=root << _EOF_
	CREATE DATABASE $MARIADB_DATABASE;
	CREATE USER '$MARIADB_ADMIN'@'localhost' IDENTIFIED BY '$MARIADB_ADMIN_PASSWORD';
	GRANT ALL ON $MARIADB_DATABASE.* TO '$MARIADB_ADMIN'@'localhost';
	CREATE USER '$MARIADB_USER'@'localhost' IDENTIFIED BY '$MARIADB_USER_PASSWORD';
	GRANT SELECT ON $MARIADB_DATABASE.* TO '$MARIADB_USER'@'localhost';
	FLUSH PRIVILEGES;
_EOF_
echo "Wordpress database created!"

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
