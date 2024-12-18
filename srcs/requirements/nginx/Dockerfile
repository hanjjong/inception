# 1. 베이스 이미지 설정 (Debian)
FROM debian:bullseye

# 2. 필요한 패키지 설치
RUN apt update && apt install -y \
    nginx \
    bash \
    openssl \
    systemctl \
    psmisc \
    tree \ 
    dumb-init
    # mkdir -p /run/nginx

RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/private.key \
    -out /etc/nginx/ssl/certificate.crt \
    -subj "/C=US/ST=State/L=City/O=Organization/CN=localhost"

# 3. Nginx 설정 파일 복사
# COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf
# 4. 웹 루트 디렉토리 생성
# RUN mkdir -p /var/www/html && \
#     chown -R www-data:www-data /var/www/html && \
#     chmod -R 755 /var/www/html

# 5. 포트 열기
EXPOSE 443

# 6. Nginx 실행
CMD ["dumb-init", "nginx", "-g", "daemon off;"]
