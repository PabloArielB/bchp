FROM alpine:3.18

RUN apk update && apk add --no-cache \
    autoconf automake libtool m4 pkgconf \
    boost-dev openssl-dev postgresql-dev gsl-dev \
    yasm git make g++

WORKDIR /bchpool
COPY . .

RUN chmod +x autogen.sh && \
    ./autogen.sh && \
    ./configure --with-ckdb && \
    make

EXPOSE 32888
CMD ["./src/ckpool", "--config", "/bchpool/config/ckpool.conf"]
