ARG PHP_VERSION=8.3.7
ARG COMPOSER_VERSION=2.7.6
ARG NODE_VERSION=20.13.1

FROM composer:${COMPOSER_VERSION} as composer

FROM node:${NODE_VERSION}-bullseye as frontend_builder

COPY /web/client/ /client

RUN cd /client && npm install && npm run build

FROM php:${PHP_VERSION}-apache-bullseye as php

RUN apt-get update && apt-get upgrade -y

COPY --from=composer /usr/bin/composer /usr/bin/composer

# Copy frontend build
COPY --from=frontend_builder /client/out /var/www/html

RUN a2enmod rewrite