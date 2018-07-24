FROM alpine:edge

LABEL version="1.0"
LABEL maintainer="Alejandro Sanchez <emailforasr@gmail.com>"

RUN apk --no-cache add tini git openssh-client bash \
    && apk --no-cache add --virtual devs curl tar coreutils gnupg

# Install Caddy Server, and All Middleware
RUN curl https://getcaddy.com | bash -s personal http.cache,http.cors,http.ipfilter,http.jwt

# Remove build devs
RUN apk del devs

# Copy over a default Caddyfile
COPY ./Caddyfile /etc/Caddyfile

# USER caddy

ENTRYPOINT ["/sbin/tini"]

CMD ["caddy", "-quic", "--conf", "/etc/Caddyfile"]
