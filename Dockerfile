FROM php:8.1-apache

RUN apt-get update
RUN apt-get install --yes --force-yes cron g++ gettext zip unzip git libicu-dev openssl libc-client-dev libkrb5-dev libxml2-dev libfreetype6-dev libgd-dev libmcrypt-dev bzip2 libbz2-dev libtidy-dev libcurl4-openssl-dev libz-dev libmemcached-dev libxslt-dev

# install the ssl-cert package which will create a "snakeoil" keypair
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y ssl-cert \
 && rm -r /var/lib/apt/lists/*

# enable ssl module and enable the default-ssl site
RUN a2enmod ssl \
 && a2ensite default-ssl

RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

RUN docker-php-ext-install mysqli
RUN docker-php-ext-enable mysqli

RUN docker-php-ext-configure gd --with-freetype=/usr --with-jpeg=/usr
RUN docker-php-ext-install gd

RUN docker-php-ext-install xml

# Install Composer
COPY ./docker/conf.d/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY ./docker/conf.d/default-ssl.conf /etc/apache2/sites-available/default-ssl.conf
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer