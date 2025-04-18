FROM alpine:3.21.3

RUN set -x \
     && apk add --no-cache \
        ca-certificates \
        curl \
     && curl -o /etc/apk/keys/angie-signing.rsa https://angie.software/keys/angie-signing.rsa \
     && echo "https://download.angie.software/angie/alpine/v$(egrep -o \
            '[0-9]+\.[0-9]+' /etc/alpine-release)/main" >> /etc/apk/repositories \
     && apk add --no-cache  \
        angie \
        angie-module-geoip2 \
        angie-module-njs \
        angie-console-light \
     && rm /etc/apk/keys/angie-signing.rsa \
     \
     && mkdir -p /var/angie/cache && chown -R angie:angie /var/angie/cache\
     && ln -sf /dev/stdout /var/log/angie/access.log \
     && ln -sf /dev/stderr /var/log/angie/error.log

EXPOSE 80 443

CMD ["angie", "-g", "daemon off;"]
