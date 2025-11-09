FROM debian:bookworm

RUN apt-get update && apt-get install -y mariadb-server

#run build timeda çalıştırılır, cmd ise konteynır çalıştırıldığında çalışır

EXPOSE 3306
#mariadb'nin default ayarlarını değiştirmek için yapıyoruz

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools/init_mariadb.sh /var/www/

RUN chmod +x /var/www/init_mariadb.sh

CMD ["/var/www/init_mariadb.sh"]