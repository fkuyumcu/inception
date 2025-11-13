#!/bin/bash


mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

#bg
mysqld --user=mysql --datadir=/var/lib/mysql &


until mysqladmin ping --silent; do
    echo 'Waiting for MariaDB to be ready...'
    sleep 2
done

mysql -u root << EOF
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

echo "DB Created Successfully"

mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown

exec mysqld --user=mysql --datadir=/var/lib/mysql
