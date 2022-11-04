#!/bin/sh

sleep 3

echo "Generating configuration file for Wordpress!"
wp config create --dbname=$MARIADB_DATABASE --dbuser=$MARIADB_ADMIN \
	--dbpass=$MARIADB_ADMIN_PASSWORD --dbhost=mariadb
echo "Wordpress configuration file generated!"

echo "Starting PHP-FPM!"
php-fpm7 -F -R
