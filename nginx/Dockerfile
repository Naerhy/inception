FROM debian:10-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update \
	&& apt-get -y install apt-utils \
	&& apt-get -y install nginx \
	&& apt-get -y install openssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/ssl/private/selfsigned.key \
	-out /etc/ssl/certs/selfsigned.crt \
	-subj="/C=FR/ST=IDF/L=Paris/O=42Paris/CN=localhost"

COPY nginx.conf /etc/nginx/

CMD ["nginx", "-g", "daemon off;"]
