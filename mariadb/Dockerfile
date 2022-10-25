FROM debian:10-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
	&& apt-get -y install apt-utils

RUN apt-get update \
	&& apt-get install -y apt-transport-https curl \
	&& curl -o /etc/apt/trusted.gpg.d/mariadb_release_signing_key.asc 'https://mariadb.org/mariadb_release_signing_key.asc' \
	&& sh -c "echo 'deb https://mirrors.ircam.fr/pub/mariadb/repo/10.9/debian buster main' >>/etc/apt/sources.list"

RUN apt-get update \
	&& apt-get install -y mariadb-server

RUN mkdir run/mysqld

CMD ["mariadbd", "--user=root"]

#RUN /etc/init.d/mysql start

#WORKDIR .

#COPY mariadb_script.sh .

#RUN chmod +x mariadb_script.sh

#ENTRYPOINT ["/mariadb_script.sh"]

#CMD ["mysqld"]
