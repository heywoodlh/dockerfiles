FROM rsyslog/syslog_appliance_alpine

## SSL Stuff
RUN apk update && apk add rsyslog-tls \
           gnutls-utils \
           gnutls

COPY    rsyslog.conf.d/logserver.conf /etc/rsyslog.conf.d/
EXPOSE 1514
