FROM alpine:3.15

RUN apk update \
	&& apk add nginx \
	&& apk add openssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/ssl1.1/private/selfsigned.key \
	-out /etc/ssl1.1/certs/selfsigned.crt \
	-subj="/C=FR/ST=IDF/L=Paris/O=42Paris/CN=localhost"

COPY nginx.conf etc/nginx/

CMD ["nginx", "-g", "daemon off;"]
