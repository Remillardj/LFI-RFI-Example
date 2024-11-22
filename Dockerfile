FROM php:7.0-apache
COPY src/ /var/www/html
EXPOSE 80
RUN echo "allow_url_include=1" > /usr/local/etc/php/conf.d/allow_url_include.ini
