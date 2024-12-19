if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ];
    then
    mysql_install_db --datadir=/var/lib/mysql --auth-root-authentication-method=normal >/dev/null
    mysqld --bootstrap << EOF
    use mysql;
    flush privileges;
    create database $MYSQL_DATABASE;
    create user '$MYSQL_USER'@'%' identified by '$MYSQL_PASSWORD';
    grant all privileges on $MYSQL_DATABASE.* to '$MYSQL_USER'@'%';
    # alter user '$MYSQL_ROOT'@'localhost' identified by '$MYSQL_ROOT_PASSWORD';
    GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_ROOT'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
    flush privileges;
EOF
fi

# if [ ! -d "/var/lib/mysql/mysql" ]; then
#     mysql_install_db --datadir=/var/lib/mysql --auth-root-authentication-method=normal >/dev/null
#     mysqld --bootstrap << EOF
#     use mysql;
#     flush privileges;
#     create database IF NOT EXISTS $MYSQL_DATABASE;
#     create user IF NOT EXISTS '$MYSQL_USER'@'%' identified by '$MYSQL_PASSWORD';
#     grant all privileges on $MYSQL_DATABASE.* to '$MYSQL_USER'@'%';
#     GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_ROOT'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
#     flush privileges;
# EOF
# fi


chmod -R 755 /var/lib/mysql

exec "$@"