FROM alpine:3.15

RUN apk update \
	&& apk add php7-fpm php7-opcache php7-phar php7-json php7-curl php7-mysqli php7-mbstring

RUN apk update \
	&& apk add curl \
	&& curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN apk update \
	&& apk add mysql-client

RUN chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

RUN mkdir wordpress && wp core download --path=wordpress/

COPY www.conf etc/php7/php-fpm.d/

WORKDIR /wordpress/

COPY init.sh .
RUN chmod +x init.sh

CMD ["./init.sh"]
