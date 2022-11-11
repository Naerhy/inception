#!/bin/sh

while ! mysql --user=$MARIADB_LOGIN --password=$MARIADB_PASSWORD -h mariadb --execute "SHOW DATABASES;" > /dev/null
do
	sleep 5
done

if [ ! -e wp-config.php ]
then
	echo "Generating configuration file for Wordpress..."
	wp config create --dbname=$MARIADB_DATABASE --dbuser=$MARIADB_LOGIN \
		--dbpass=$MARIADB_PASSWORD --dbhost=mariadb
	echo "Wordpress configuration file generated!"

	echo "Installing Wordpress..."
	wp core install --url=localhost --title="Inception" --admin_user=$WP_ADMIN_LOGIN \
		--admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --skip-email
	echo "Wordpress is installed!"

	echo "Creating second user.."
	wp user create $WP_AUTHOR_LOGIN $WP_AUTHOR_EMAIL --user_pass=$WP_AUTHOR_PASSWORD --role=author
	echo "Second user created!"

	echo "Installing Wordpress theme..."
	wp theme install twentytwentyone --activate
	echo "Wordpress theme installed!"
fi

echo "Starting PHP-FPM..."
exec php-fpm7 -F -R
