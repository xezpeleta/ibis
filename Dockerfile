FROM php:7.4-cli

# Install dependencies
RUN apt-get update && apt-get install -y \
        zip \
        unzip \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd 

# Install Composer and Ibis
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer global require themsaid/ibis \
    && mkdir /data
VOLUME /data
WORKDIR /data
ENTRYPOINT ["/root/.composer/vendor/themsaid/ibis/ibis"]
