FROM php:apache

# Install modules
RUN apt-get update && apt-get install -y \
        libmcrypt-dev \
        libpq-dev \
    && docker-php-ext-install iconv mcrypt mbstring mysqli pgsql pdo pdo_mysql pdo_pgsql

COPY . /var/www/html
