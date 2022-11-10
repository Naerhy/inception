FROM alpine:3.15

RUN apk update \
	&& apk add mysql mysql-client

RUN mkdir run/mysqld

RUN mysql_install_db --user=root --datadir=/var/lib/mysql

COPY mariadb-server.cnf etc/my.cnf.d/

COPY init.sh .
RUN chmod +x init.sh

CMD ["./init.sh"]
