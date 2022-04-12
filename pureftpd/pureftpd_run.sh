#!/bin/sh
#
# 

# configure
: "${PUREFTPD_HOSTNAME:=localhost}"
: "${PUREFTPD_PASSIVE_PORTS:=40000:40010}"
: "${PUREFTPD_MAX_CLIENTS:=5}"
: "${PUREFTPD_MAX_CONNECTIONS:=5}"

set -euxo pipefail

if [ -e "/etc/pureftpd/pureftpd.passwd" ]  ; then
    pure-pw mkdb /etc/pureftpd/pureftpd.pdb -f /etc/pureftpd/pureftpd.passwd
fi

echo "Starting Pure-FTPd:"

exec /usr/sbin/pure-ftpd $@ -p ${PUREFTPD_PASSIVE_PORTS} -P ${PUREFTPD_HOSTNAME} -c ${PUREFTPD_MAX_CLIENTS} -C ${PUREFTPD_MAX_CONNECTIONS}
