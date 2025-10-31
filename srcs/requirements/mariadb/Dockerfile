FROM debian:bookworm

RUN apt-get update && apt-get install -y mariadb-server

#run build timeda çalıştırılır, cmd ise konteynır çalıştırıldığında çalışır

EXPOSE 3306

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools /var/www/

RUN chmod +x /var/www/init_mariadb.sh

CMD ["/var/www/init_mariadb.sh"]