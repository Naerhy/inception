#!/bin/sh

sleep 3

echo "Generating configuration file for Wordpress..."
wp config create --dbname=$MARIADB_DATABASE --dbuser=$MARIADB_ADMIN \
	--dbpass=$MARIADB_ADMIN_PASSWORD --dbhost=mariadb
echo "Wordpress configuration file generated!"

echo "Installing Wordpress..."
wp core install --url=localhost --title="Inception" --admin_user=$WP_ADMIN \
	--admin_password=$WP_ADMIN_PASSWORD --admin_email=inception@student.42.fr --skip-email
echo "Wordpress is installed!"

echo "Starting PHP-FPM..."
php-fpm7 -F -R
