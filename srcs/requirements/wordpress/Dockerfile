FROM debian:bookworm

RUN apt-get update && apt-get -y install \
 wget \
 curl \
 bash \
 php \
 php-cgi \
 php-mysql \
 php-fpm \
 php-pdo \
 php-gd php-cli \
 php-mbstring \
 redis \
 php-redis \
 && rm -rf /var/lib/apt/lists/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && chmod +x wp-cli.phar \
  && mv wp-cli.phar /usr/local/bin/wp
    #wp cli kuruyorum, wordpress komutlarını konteynırlar içinde kullanabilmemi sağlıyor

COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/

RUN mkdir -p /run/php

COPY ./tools/create_wordpress.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/create_wordpress.sh
ENTRYPOINT ["/usr/local/bin/create_wordpress.sh"]

WORKDIR /var/www/html/

EXPOSE 9000

CMD ["php-fpm8.2", "-F"]