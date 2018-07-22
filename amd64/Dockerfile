FROM amd64/alpine:3.8

LABEL maintainer="Niklas <dev@n1klas.net>"

ENV VERSION 1.5

ADD libressl.patch /

RUN set -x; \
    GPGKEY='A0D6EEA1DCAE49A635A3B2F0779B22DFB3E717B7' \
    && apk add --no-cache --virtual .build-deps \
        gcc \
        g++ \
        make \
        libc-dev \
        libressl-dev \
        c-ares-dev \
        util-linux-dev \
	    libwebsockets-dev \
        curl \
        gnupg \
    && curl -fSL http://mosquitto.org/files/source/mosquitto-$VERSION.tar.gz -o mosquitto.tar.gz \
    && curl -fSL http://mosquitto.org/files/source/mosquitto-$VERSION.tar.gz.asc -o mosquitto.tar.gz.asc \
    && export GNUPGHOME="$(mktemp -d)" \
	&& found=''; \
	for server in \
		ha.pool.sks-keyservers.net \
		hkp://keyserver.ubuntu.com:80 \
		hkp://p80.pool.sks-keyservers.net:80 \
		pgp.mit.edu \
	; do \
		echo "Fetching GPG key $GPGKEY from $server"; \
		gpg --keyserver "$server" --keyserver-options timeout=10 --recv-keys "$GPGKEY" && found=yes && break; \
	done; \
	test -z "$found" && echo >&2 "error: failed to fetch GPG key $GPGKEY" && exit 1; \
	gpg --batch --verify mosquitto.tar.gz.asc mosquitto.tar.gz \
    && rm -rf "$GNUPGHOME" mosquitto.tar.gz.asc \
    && mkdir -p /usr/src \
    && tar -xzC /usr/src -f mosquitto.tar.gz \
    && rm mosquitto.tar.gz \
    && cd /usr/src/mosquitto-$VERSION \
    && patch -p1 -i /libressl.patch \
    && rm /libressl.patch \
    && make -j$(getconf _NPROCESSORS_ONLN) \
		WITH_MEMORY_TRACKING=no \
		WITH_WEBSOCKETS=yes \
		WITH_SRV=yes \
		WITH_TLS_PSK=no \
		prefix=/usr \
    && make install \
    && rm -rf /usr/src/mosquitto-$VERSION \
    && runDeps="$( \
		scanelf --needed --nobanner --format '%n#p' /usr/local/sbin/mosquitto /usr/local/bin/mosquitto_passwd \
			| tr ',' '\n' \
			| sort -u \
			| awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
	)" \
	&& apk add --no-cache --virtual .rundeps $runDeps \
	&& apk del .build-deps \
    && mv /etc/mosquitto/mosquitto.conf.example /etc/mosquitto/mosquitto.conf \
    && addgroup -S mosquitto \
    && adduser -D -S -H -h /var/empty -s /sbin/nologin -G mosquitto -g Mosquitto mosquitto

EXPOSE 1883
    
CMD ["mosquitto", "-c", "/etc/mosquitto/mosquitto.conf"]