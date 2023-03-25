# COPY FROM frolvlad/alpine-glibc (https://github.com/Docker-Hub-frolvlad/docker-alpine-glibc/blob/master/Dockerfile)
FROM alpine:3.17

ENV LANG=C.UTF-8

# NOTE: Glibc 2.35 package is broken: https://github.com/sgerrand/alpine-pkg-glibc/issues/176, so we stick to 2.34 for now
RUN ALPINE_GLIBC_BASE_URL="https://github.com/sgerrand/alpine-pkg-glibc/releases/download" && \
    ALPINE_GLIBC_PACKAGE_VERSION="2.34-r0" && \
    ALPINE_GLIBC_BASE_PACKAGE_FILENAME="glibc-$ALPINE_GLIBC_PACKAGE_VERSION.apk" && \
    ALPINE_GLIBC_BIN_PACKAGE_FILENAME="glibc-bin-$ALPINE_GLIBC_PACKAGE_VERSION.apk" && \
    ALPINE_GLIBC_I18N_PACKAGE_FILENAME="glibc-i18n-$ALPINE_GLIBC_PACKAGE_VERSION.apk" && \
    apk add --no-cache --virtual=.build-dependencies wget ca-certificates && \
    echo \
        "-----BEGIN PUBLIC KEY-----\
        MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApZ2u1KJKUu/fW4A25y9m\
        y70AGEa/J3Wi5ibNVGNn1gT1r0VfgeWd0pUybS4UmcHdiNzxJPgoWQhV2SSW1JYu\
        tOqKZF5QSN6X937PTUpNBjUvLtTQ1ve1fp39uf/lEXPpFpOPL88LKnDBgbh7wkCp\
        m2KzLVGChf83MS0ShL6G9EQIAUxLm99VpgRjwqTQ/KfzGtpke1wqws4au0Ab4qPY\
        KXvMLSPLUp7cfulWvhmZSegr5AdhNw5KNizPqCJT8ZrGvgHypXyiFvvAH5YRtSsc\
        Zvo9GI2e2MaZyo9/lvb+LbLEJZKEQckqRj4P26gmASrZEPStwc+yqy1ShHLA0j6m\
        1QIDAQAB\
        -----END PUBLIC KEY-----" | sed 's/   */\n/g' > "/etc/apk/keys/sgerrand.rsa.pub" && \
    wget \
        "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_I18N_PACKAGE_FILENAME" && \
    mv /etc/nsswitch.conf /etc/nsswitch.conf.bak && \
    apk add --no-cache --force-overwrite \
        "$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_I18N_PACKAGE_FILENAME" && \
    \
    mv /etc/nsswitch.conf.bak /etc/nsswitch.conf && \
    rm "/etc/apk/keys/sgerrand.rsa.pub" && \
    (/usr/glibc-compat/bin/localedef --force --inputfile POSIX --charmap UTF-8 "$LANG" || true) && \
    echo "export LANG=$LANG" > /etc/profile.d/locale.sh && \
    \
    apk del glibc-i18n && \
    \
    rm "/root/.wget-hsts" && \
    apk del .build-dependencies && \
    rm \
        "$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_I18N_PACKAGE_FILENAME"

RUN CCL_VERSION="1.12.1" && \
    ARCH="linuxx86" && \
    FILENAME="ccl-$CCL_VERSION-$ARCH.tar.gz" && \
    DOWNLOAD_URL="https://github.com/Clozure/ccl/releases/download/v$CCL_VERSION/$FILENAME" && \
    busybox wget "$DOWNLOAD_URL" && \
    tar zxf $FILENAME && \
    mkdir /opt/ccl && \
    cp -r ccl/lx86cl64* ccl/x86-headers64 /opt/ccl && \
    ln -s /opt/ccl/lx86cl64 /usr/local/bin/ccl && \
    rm -rf ccl $FILENAME

RUN busybox wget https://beta.quicklisp.org/quicklisp.lisp && \
    ccl --load quicklisp.lisp \
        --eval "(quicklisp-quickstart:install :path \"/opt/quicklisp/\")" \
        --eval "(ql:quickload :swank)" \
        --eval "(quit)" && \
    rm quicklisp.lisp

# Use latest asdf to make use of new feature such as package inferred system
RUN busybox wget -P /opt/quicklisp https://common-lisp.net/project/asdf/archives/asdf.lisp

EXPOSE 4005
# CMD ccl --load ~/quicklisp/setup.lisp \
#         --eval "(ql:quickload :swank)" \
#         --eval "(require :swank)" \
#         --eval "(setq swank::*loopback-interface* \"0.0.0.0\")" \
#         --eval "(swank:create-server :port 4005 :dont-close t)"
#         --eval "(sleep 315360000000)"
