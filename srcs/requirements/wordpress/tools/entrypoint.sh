rm -rf /var/www/html/wp-config-sample.php
rm -rf /var/www/html/*
cd /var/www/html

wp core download --allow-root

wp config create \
    --skip-check \
    --dbname=${MYSQL_DATABASE} \
    --dbuser=${MYSQL_USER} \
    --dbpass=${MYSQL_ROOT_PASSWORD} \
    --dbhost=${WP_DB_HOST} \
    --allow-root

wp core install \
    --url=${DOMAIN_NAME} \
    --title=${WP_TITLE} \
    --admin_user=${WP_ADMIN_NAME} \
    --admin_password=${WP_ADMIN_PASSWORD} \
    --admin_email=${WP_ADMIN_EMAIL} \
    --skip-email \
    --allow-root

wp user create ${WP_USER} ${WP_USER_EMAIL} --allow-root
wp user update ${WP_USER} --user_pass=${WP_USER_PASSWORD} --allow-root

chown www-data:www-data /var/www/html/wp-config.php
mkdir -p /run/php
exec $@