FROM php:7.1.3-fpm

RUN apt-get update && docker-php-ext-install -j$(nproc) iconv mysqli pdo_mysql

RUN curl -sS https://getcomposer.org/installer | \
    php -- --install-dir=/usr/bin/ --filename=composer

COPY ./configuration/php.ini /usr/local/etc/php/php.ini
