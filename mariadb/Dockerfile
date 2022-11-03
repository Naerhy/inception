FROM alpine:3.15

RUN apk update \
	&& apk add mysql mysql-client

RUN mkdir run/mysqld

RUN mysql_install_db --user=root --datadir=/var/lib/mysql

COPY init.sh .
RUN chmod +x init.sh

# remove this and add to docker compose instead
ENV MARIADB_ROOT_PASSWORD="thisisapassword"
ENV MARIADB_DATABASE="wordpress"
ENV MARIADB_ADMIN="bossintheroom"
ENV MARIADB_ADMIN_PASSWORD="fweygvewp"
ENV MARIADB_USER="user"
ENV MARIADB_USER_PASSWORD="nfwefewyg"

RUN ./init.sh

CMD ["mariadbd", "--user=root"]
