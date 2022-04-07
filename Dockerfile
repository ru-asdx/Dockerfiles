FROM alpine:latest as builder
MAINTAINER asdx "eugene@skorlov.name"

ARG VER=1.3.8rc1

ADD https://github.com/sleinen/samplicator/releases/download/$VER/samplicator-$VER.tar.gz /

RUN apk add --update build-base automake autoconf && \
    tar -xzvf /samplicator-$VER.tar.gz && \
    cd /samplicator-$VER/ && \
    ./configure && \
    make


FROM alpine:latest
MAINTAINER asdx "eugene@skorlov.name"

ARG VER=1.3.8rc1

COPY --from=builder /samplicator-$VER/samplicate /
ENTRYPOINT ["/samplicate"]
