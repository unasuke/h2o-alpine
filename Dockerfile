FROM alpine

ENV H2O_VERSION=v2.2.3

RUN apk add --no-cache --virtual=builddeps \
        bison           \
        ca-certificates \
        cmake           \
        curl            \
        gcc             \
        git             \
        g++             \
        libc-dev        \
        linux-headers   \
        make            \
        openssl         \
        perl            \
        ruby            \
        ruby-dev        \
        wget            \
        zlib-dev        \
    && wget -O - https://github.com/h2o/h2o/archive/${H2O_VERSION}.tar.gz | tar xz \
    && cd h2o-* \
    && cmake -DWITH_BUNDLED_SSL=on -DWITH_MRUBY=on . \
    && make install \
    && cd .. \
    && rm -rf h2o-* \
    && apk del builddeps \
    && apk add --no-cache --virtual=rundeps \
        libstdc++ \
        perl

RUN mkdir /etc/h2o

WORKDIR /etc/h2o

EXPOSE 80 443
