FROM alpine:3.17

RUN apk add --no-cache iperf3 tini \
  && adduser -S iperf

USER iperf

# Expose the default iperf3 server ports
EXPOSE 5201/tcp 5201/udp

ENTRYPOINT [ "/sbin/tini", "--" ]

CMD ["iperf3", "-s"]
