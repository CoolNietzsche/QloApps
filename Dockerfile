FROM php:8.1-apache

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libxml2-dev \
    libzip-dev \
    zip unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysqli pdo pdo_mysql soap zip \
    && docker-php-ext-enable pdo_mysql soap zip

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Suppress Apache ServerName notice
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Copy project files
COPY . /var/www/html/

# Copy PHP configuration file
COPY php.ini /usr/local/etc/php/

# Set correct permissions
RUN chown -R www-data:www-data /var/www/html/

WORKDIR /var/www/html

EXPOSE 80

# Start Apache in the foreground
CMD ["apache2-foreground"]
