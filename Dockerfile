# Version 0.0.1 - debian stretch slim + flussonic + flussonic-ffmpeg

FROM debian:stretch-slim
MAINTAINER asdx "eugene@skorlov.name"

RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends --no-install-suggests wget gnupg1 \
    && wget -q -O - http://debian.erlyvideo.org/binary/gpg.key | apt-key add - \
    && echo "deb http://debian.erlyvideo.org binary/" > /etc/apt/sources.list.d/erlyvideo.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends --no-install-suggests flussonic flussonic-ffmpeg flussonic-python flussonic-erlang \
    && apt-get remove --purge --auto-remove -y gnupg1 wget \
    && apt-get -y clean \
    && rm -rf /tmp/* /var/tmp/*  /var/lib/apt/lists/*

EXPOSE 80 8080 1935 554
VOLUME ["/etc/flussonic", "/var/log/flussonic", "/srv/storage"]

ENTRYPOINT ["/opt/flussonic/bin/flussonic", "-n", "flussonic@127.0.0.1", "-p", "/var/run/flussonic/pid", "-l", "/var/log/flussonic", "-e", "production"]
