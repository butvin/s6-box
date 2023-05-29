FROM php:8.1-fpm
ARG DEBIAN_FRONTEND=noninteractive
ARG env

RUN set -e;
RUN apt-get update --fix-missing \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
        apt-utils \
        curl \
        wget \
        git \
        libimage-exiftool-perl \
        libzip-dev \
        zip \
        unzip \
        p7zip-full \
        sendmail \
    && rm -rf /var/lib/apt/lists/*

# Dependen
RUN apt-get update --fix-missing \
    && apt-get install -y python \
    && rm -rf /var/lib/apt/lists/*

# xDebug
ARG DOCKER_INTERNAL_HOST
ARG XDEBUG_ENABLE=0

RUN if [ "1" = "${XDEBUG_ENABLE}" ]; then \
      pecl install xdebug \
      && docker-php-ext-enable xdebug \
      && echo "xdebug.remote_host=${DOCKER_INTERNAL_HOST}\n" >> "$PHP_INI_DIR"/conf.d/docker-php-ext-xdebug.ini; \
    fi

RUN docker-php-ext-install zip mysqli pdo pdo_mysql opcache

# Redis
RUN pecl install -o -f redis
RUN docker-php-ext-enable redis

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- \
    --filename=composer \
    --install-dir=/usr/local/bin && \
    echo "alias composer='COMPOSER_MEMORY_LIMIT=-1 composer'" >> /root/.bashrc

RUN echo "sendmail_path=/usr/sbin/sendmail -t -i" >> /usr/local/etc/php/conf.d/sendmail.ini
RUN sed -i '/#!\/bin\/sh/aservice sendmail restart' /usr/local/bin/docker-php-entrypoint
RUN sed -i '/#!\/bin\/sh/aecho "$(hostname -i)\t$(hostname) $(hostname).localhost" >> /etc/hosts' /usr/local/bin/docker-php-entrypoint

COPY www.conf /usr/local/etc/php-fpm.d

COPY ${env}/opcache.ini "$PHP_INI_DIR"/conf.d
COPY ${env}/php.ini "$PHP_INI_DIR"/conf.d
COPY ${env}/xdebug.ini "$PHP_INI_DIR"/conf.d

RUN rm -rf /tmp/pear

WORKDIR "/application"