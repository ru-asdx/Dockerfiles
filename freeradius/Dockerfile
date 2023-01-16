ARG from=alpine:3.13

FROM ${from} as build

#
#  Install build dependencies
#
RUN apk update \
    && apk add git gcc make libc-dev talloc-dev openssl openssl-dev linux-headers \
        pcre-dev libidn-dev krb5-dev samba-dev curl-dev json-c-dev openldap-dev \
        unbound-dev ruby-dev perl-dev python2-dev hiredis-dev libmemcached-dev \
        gdbm-dev libcouchbase-dev postgresql-dev mariadb-dev unixodbc-dev sqlite-dev

#
#  clone the FreeRADIUS source
#
ARG source=https://github.com/FreeRADIUS/freeradius-server.git
ARG release=v3.2.x

RUN git clone --depth 1 --single-branch --branch ${release} ${source} /tmp/freeradius
WORKDIR /tmp/freeradius

#
#  Build the server
#
RUN ./configure --prefix=/opt \
    && make -j2 \
    && make install \
    && rm /opt/lib/*.a

#
#  Clean environment and run the server
#
FROM ${from}
COPY --from=build /opt /opt

#
# These are needed for the server to start
#
RUN apk update \
    && apk add talloc libressl pcre libwbclient tzdata tini \
    && apk add libcurl json-c libldap hiredis sqlite-dev \
    \
#
#  Libraries that are needed dependent on which modules are used
#  Some of these (especially the languages) are huge. A reasonable
#  selection has been enabled here. If you use modules needing
#  other dependencies then install any others required in your
#  local Dockerfile.
#
#RUN apk add libidn krb5
#RUN apk add unbound-libs
#RUN apk add ruby-libs perl python2-dev
#RUN apk add libmemcached gdbm libcouchbase
#RUN apk add postgresql-dev mariadb-dev unixodbc-dev
#
    \
    && ln -s /opt/etc/raddb /etc/raddb \
    && rm -rf /var/cache/apk/*


EXPOSE 1812/udp 1813/udp

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/opt/sbin/radiusd", "-f", "-l", "stdout"]
