ARG from=debian:bookworm-slim

FROM ${from} as build

ENV DEBIAN_FRONTEND noninteractive

RUN apt update \
    && apt install -y --no-install-recommends tcl pkg-config cmake libssl-dev build-essential git ca-certificates \
    && git clone https://github.com/Haivision/srt /tmp/srt

WORKDIR /tmp/srt

#
#  Build it
#
RUN ./configure && make


#
#  Clean environment
#
FROM ${from}

ENV DEBIAN_FRONTEND noninteractive

COPY --from=build /tmp/srt/srt-live-transmit /app/

RUN apt update \
    && apt install libssl3 tini \
    && apt -y clean \
    && rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/* \
    && useradd -m -r overcast \
    && ln -s /app/srt-live-transmit /usr/bin/srt-live-transmit

USER overcast
WORKDIR /app

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["/app/srt-live-transmit"]
