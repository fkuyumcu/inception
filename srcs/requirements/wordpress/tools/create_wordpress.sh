#!/bin/sh
#wordpressin config dosyasını oluşturuyorum
if [ -f ./wp-config.php ]
then
	echo "Wordpress already downloaded"
else

######## MANDATORY ########
    echo "O Captain My Captain"
	wget http://wordpress.org/latest.tar.gz
	tar xfz latest.tar.gz
	mv wordpress/* .
	rm -rf latest.tar.gz
	rm -rf wordpress

	# Create wp-config.php using WP-CLI
	wp config create --allow-root \
		--dbname=$MYSQL_DATABASE \
		--dbuser=$MYSQL_USER \
		--dbpass=$MYSQL_PASSWORD \
		--dbhost=$MYSQL_HOSTNAME \
		--path=/var/www/html

	# Install WordPress
	wp core install --allow-root \
		--url=$DOMAIN \
		--title="$brand" \
		--admin_user=$login \
		--admin_password=$wp_user_pwd \
		--admin_email=$wp_user_email \
		--path=/var/www/html

	echo "WordPress installation completed!"
fi

exec "$@"