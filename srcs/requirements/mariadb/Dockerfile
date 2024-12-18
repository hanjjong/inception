FROM debian:bullseye

RUN apt-get update && apt-get install -y --no-install-recommends \
    mariadb-server \
    mariadb-client \
    tzdata && \ 
    mkdir -p /run/mysqld && \
    chown -R mysql:mysql /run/mysqld /var/lib/mysql && \
    chmod -R 777 /run/mysqld /var/lib/mysql && \
    rm -rf /var/lib/apt/lists/*


COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/entrypoint.sh ./tmp
RUN chmod +x ./tmp/entrypoint.sh /etc/mysql/mariadb.conf.d/50-server.cnf
# 5. 실행 포트 열기
EXPOSE 3306

# 6. 컨테이너 실행 시 MariaDB 실행
ENTRYPOINT ["sh", "./tmp/entrypoint.sh"]
# CMD ["mysqld","--datadir=/var/lib/mysql"]
CMD ["mysqld", "--user=mysql", "--datadir=/var/lib/mysql"]
