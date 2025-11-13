
#!/bin/bash

if [ ! -f /etc/nginx/ssl/nginx.crt ]; then
echo "setting up ssl";
openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt -subj "/C=TR/ST=ISTANBUL/L=SARIYER/O=42Ist/CN=fkuyumcu.42.fr";
echo "SSL ready";
fi

exec "$@"