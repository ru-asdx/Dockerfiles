FROM alpine:edge
MAINTAINER asdx

RUN apk add --update -X http://dl-cdn.alpinelinux.org/alpine/edge/testing pure-ftpd tini; \
    rm -rf /var/cache/apk/* ;

COPY pureftpd_run.sh /

VOLUME ["/home/ftp", "/etc/pureftpd/"]
EXPOSE 21 40000-40010

ENTRYPOINT [ "/sbin/tini", "--" ]
CMD [ "/pureftpd_run.sh", "-l", "puredb:/etc/pureftpd/pureftpd.pdb", "-E", "-j", "-R", "-A" ]
