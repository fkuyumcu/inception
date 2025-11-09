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

# mysql'e root olarak bağlan, heredoc ile database, user oluştur
mysql -u root << EOF
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

echo "DB Created Successfully"

#Docker bir ana process (PID 1) bekler. Bu process biterse container kapanır.

# Stop the background MariaDB
mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown

# Start MariaDB in the foreground
exec mysqld --user=mysql --datadir=/var/lib/mysql
