FROM debian:bookworm

RUN apt-get update && apt-get install -y nginx openssl

RUN mkdir /etc/nginx/ssl

COPY ./conf/nginx.conf /etc/nginx/sites-enabled/default
COPY ./tools/start.sh /var/www

RUN chmod +x /var/www/start.sh
RUN mkdir -p /run/nginx

ENTRYPOINT ["/var/www/start.sh"]

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
