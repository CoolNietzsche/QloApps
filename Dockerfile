FROM php:8.1-apache

RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev libxml2-dev zip unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysqli pdo pdo_mysql soap zip \
    && docker-php-ext-enable pdo_mysql soap zip

RUN a2enmod rewrite

COPY . /var/www/html/
COPY php.ini /usr/local/etc/php/

RUN chown -R www-data:www-data /var/www/html/

WORKDIR /var/www/html

EXPOSE 80

