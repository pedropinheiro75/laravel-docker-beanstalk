FROM php:7.2.5-fpm

LABEL maintainer="Pedro Pinheiro <pinheiro.pedrohl@gmail.com>"

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    curl \
    git \
    libfreetype6-dev \
    libicu-dev \
    libz-dev \
    libpq-dev \
    libjpeg-dev \
    libpng-dev \
    libfreetype6-dev \
    libssl-dev \
    libmcrypt-dev \
    libxslt1-dev \
    python-pip \
    redis-tools \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade setuptools

# AWS cli is nice to have on aws, think: PaaS.
RUN pip install awscli --upgrade --user

# Eb cli is nice to have on aws, think: PaaS.
RUN pip install  awsebcli --upgrade --user

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/

RUN docker-php-ext-install \
    gd \
    intl \
    pdo_mysql \
    pdo_pgsql \
    xsl \
    zip \
    opcache

RUN pecl install -o -f redis \
    &&  rm -rf /tmp/pear \
    &&  docker-php-ext-enable redis

COPY resources/conf/opcache.ini /usr/local/etc/php/conf.d/opcache.ini
COPY resources/conf/php.ini /usr/local/etc/php/
COPY resources/conf/php-fpm.conf /usr/local/etc/
COPY resources/bin/* /usr/local/bin/

RUN curl -sS https://getcomposer.org/installer | php -- -d memory=-1 --install-dir=/usr/local/bin --filename=composer --version=1.2.0

ENV APP_DIR "/src"
ENV PHP_MEMORY_LIMIT 1G
ENV PHP_PORT 9000
ENV PHP_PM dynamic
ENV PHP_PM_MAX_CHILDREN 10
ENV PHP_PM_START_SERVERS 4
ENV PHP_PM_MIN_SPARE_SERVERS 2
ENV PHP_PM_MAX_SPARE_SERVERS 6

ENV COMPOSER_HOME /home/composer

RUN mkdir -p /tmp/envs && touch /tmp/envs/env_file

CMD eval `cat /tmp/envs/env_file`; /usr/local/bin/start-laravel;