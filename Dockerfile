FROM php:8.1-fpm

WORKDIR /var/www/html

RUN apt-get update \
    && apt-get install -y ca-certificates wget libzip-dev zip

RUN docker-php-ext-install mysqli pdo pdo_mysql zip \
    && docker-php-ext-enable pdo_mysql

#does not work with volumes. only for prod build usage
RUN chown -R www-data:www-data /var/www
RUN chmod -R 777 /var/www

USER www-data