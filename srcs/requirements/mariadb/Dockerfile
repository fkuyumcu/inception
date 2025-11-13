FROM debian:bookworm

RUN apt-get update && apt-get install -y mariadb-server

#run build timeda çalıştırılır, cmd ise konteynır çalıştırıldığında çalışır

EXPOSE 3306
#mariadb'nin default ayarlarını değiştirmek için yapıyoruz

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools/mariadb.sh /var/www/

RUN chmod +x /var/www/mariadb.sh

CMD ["/var/www/mariadb.sh"]