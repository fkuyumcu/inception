FROM debian:bookworm

RUN apt-get update && apt-get install -y mariadb-server


EXPOSE 3306

COPY ./conf/mdb.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools/mariadb.sh /var/www/

RUN chmod +x /var/www/mariadb.sh

CMD ["/var/www/mariadb.sh"]