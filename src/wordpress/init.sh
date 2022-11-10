#!/bin/sh

while ! mysql --user=$MARIADB_ADMIN --password=$MARIADB_ADMIN_PASSWORD -h mariadb --execute "SHOW DATABASES;"
do
	sleep 5
done

if [ ! -e wp-config.php ]
then
	echo "Generating configuration file for Wordpress..."
	wp config create --dbname=$MARIADB_DATABASE --dbuser=$MARIADB_ADMIN \
		--dbpass=$MARIADB_ADMIN_PASSWORD --dbhost=mariadb
	echo "Wordpress configuration file generated!"

	echo "Installing Wordpress..."
	wp core install --url=localhost --title="Inception" --admin_user=$WP_ADMIN \
		--admin_password=$WP_ADMIN_PASSWORD --admin_email=inception@student.42.fr --skip-email
	echo "Wordpress is installed!"

	echo "Installing Wordpress theme..."
	wp theme install twentytwentyone --activate
	echo "Wordpress theme installed!"
fi

echo "Starting PHP-FPM..."
exec php-fpm7 -F -R
