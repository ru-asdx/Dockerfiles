# Version: 0.0.2 - debian stretch slim + asterisk 13 + fail2ban

FROM debian:stretch-slim
MAINTAINER asdx "eugene@skorlov.name"

RUN apt-get update \
    && apt-get install -y --no-install-recommends ntp iptables procps fail2ban \
	asterisk asterisk-config asterisk-modules asterisk-mp3 asterisk-mysql asterisk-voicemail asterisk-core-sounds-en asterisk-core-sounds-ru \
    && apt-get -y autoremove \
    && apt-get -y clean \
    && rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/* /etc/fail2ban/jail.d/defaults-debian.conf

COPY files/ /

WORKDIR /
ENTRYPOINT ["/start"]
