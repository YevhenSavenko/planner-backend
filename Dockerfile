####################################################################################################################
### Layer with PHP and installed required packages for lumen.
####################################################################################################################
FROM php:8.2-fpm-alpine3.17 as php

COPY --from=composer:2.0.7 /usr/bin/composer /usr/bin/composer

RUN apk add --no-cache \
    && apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        bison \
        build-base \
        flex \
        oniguruma-dev \
        re2c \
    && docker-php-ext-install bcmath ctype mbstring pdo pdo_mysql \
    && apk del .build-deps

EXPOSE 9000

CMD ["php-fpm"]




####################################################################################################################
### Layer with lumen for production.
####################################################################################################################
FROM php as production

WORKDIR /app

RUN addgroup --gid 501 app \
    && adduser --uid 501 --ingroup app --shell /bin/sh --no-create-home --disabled-password app \
    && chown -R app: /app

USER app:app

COPY --chown=app:app composer.* ./
COPY --chown=app:app . ./

RUN composer install --no-dev --optimize-autoloader




####################################################################################################################
### Layer with lumen for develop.
####################################################################################################################
FROM php as develop

WORKDIR /app

ARG DOCKER_USER_ID=1000
ARG DOCKER_GROUP_ID=1000

RUN apk add --no-cache \
        && apk add --no-cache --virtual .build-deps \
            $PHPIZE_DEPS \
            linux-headers \
    && export PHP_AUTOCONF=$(which autoconf) \
    && pecl install xdebug \
            && docker-php-ext-enable xdebug \
    && apk del .build-deps \
    && addgroup --gid ${DOCKER_GROUP_ID} app \
    && adduser --uid ${DOCKER_USER_ID} --ingroup app --shell /bin/sh --no-create-home --disabled-password app \
    && chown -R app: /app

USER app:app

COPY --chown=app:app composer.* ./
COPY --chown=app:app . ./

RUN composer install --dev --optimize-autoloader
