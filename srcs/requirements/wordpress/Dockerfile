FROM debian:bullseye

# Install necessary packages
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get -y install \
    php7.4 \
    php7.4-fpm \
    php-cli \
    wget \
    curl \
    php-mysql \
    php-mbstring \
    php-xml \
    dumb-init \
    vim

RUN which php-fpm7.4
RUN mkdir -p /var/www/html && chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html
RUN mkdir -p /run/php && chown -R www-data:www-data /run/php && chmod 755 /run/php

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xvf latest.tar.gz && \
    mkdir -p /var/www/html/ && \
    mv /wordpress/* /var/www/html/ && \
    chown -R www-data:www-data /var/www/html && \
    chmod 755 /var/www/html && \
    rm -r /wordpress latest.tar.gz

RUN sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 0.0.0.0:9000|' /etc/php/7.4/fpm/pool.d/www.conf
COPY ./tools/entrypoint.sh ./tmp/entrypoint.sh
RUN chmod +x ./tmp/entrypoint.sh

EXPOSE 9000
ENTRYPOINT ["dumb-init",  "--", "./tmp/entrypoint.sh"]
CMD ["php-fpm7.4", "-F"]