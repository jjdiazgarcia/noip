FROM alpine:3.10

MAINTAINER Jeronimo Diaz <jeronimo.telec@gmail.com>

RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.10/community" >> /etc/apk/repositories && \
apk --update upgrade && \
apk del wget && \
apk add make gcc libc-dev bash ca-certificates && \
rm -rf /var/cache/apk/* && \
cd /tmp/ && \
update-ca-certificates && \
apk add wget && \
wget https://www.noip.com/client/linux/noip-duc-linux.tar.gz && \
tar xvfz noip-duc-linux.tar.gz && \
cd noip-2.1.9-1 && \
make && cp noip2 /usr/local/bin/noip2 && \
chmod 755 /usr/local/bin/noip2 && \
mkdir /usr/local/etc

RUN addgroup noip && adduser -h /home/noip -s /sbin/nologin -D -G noip noip && chmod 755 /home/noip && chown -R noip:noip /usr/local/etc

COPY noip_run.sh /home/noip/noip_run.sh

RUN chmod +x /home/noip/noip_run.sh

USER noip

WORKDIR /home/noip

CMD ["noip_run.sh"]
