# Version 0.0.1 Alpine latest + unbound

FROM alpine:latest
MAINTAINER asdx "eugene@skorlov.name"

RUN apk add --update unbound ; \
    rm -rf /var/cache/apk/* ;

EXPOSE 53/udp 53/tcp

VOLUME /etc/unbound

ENTRYPOINT ["unbound", "-d"]
