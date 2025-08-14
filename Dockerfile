FROM php:8.1-apache

# Install required PHP extensions
RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install gd mysqli pdo pdo_mysql && docker-php-ext-enable pdo_mysql

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Copy project files
COPY . /var/www/html/

# Set correct permissions
RUN chown -R www-data:www-data /var/www/html/


RUN apt-get update && apt-get install -y libxml2-dev \
    && docker-php-ext-install soap \
    && docker-php-ext-enable soap

RUN apt-get install -y zip unzip \
    && docker-php-ext-install zip \
    && docker-php-ext-enable zip

# Working directory
WORKDIR /var/www/html

EXPOSE 80
