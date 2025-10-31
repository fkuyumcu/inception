#!/bin/bash

# Create the run directory for MariaDB socket
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

# Start MariaDB in the background
mysqld --user=mysql --datadir=/var/lib/mysql &

# Wait for MariaDB to be ready
until mysqladmin ping --silent; do
    echo 'Waiting for MariaDB to be ready...'
    sleep 2
done

# Run the initialization SQL
mysql < /var/www/initial_db.sql

# Remove the SQL file
rm -f /var/www/initial_db.sql

# Stop the background MariaDB
mysqladmin shutdown

# Start MariaDB in the foreground
exec mysqld --user=mysql --datadir=/var/lib/mysql
