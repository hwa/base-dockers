#!/bin/sh

set -- \
    /usr/local/bin/ccl \
    --load /opt/quicklisp/setup.lisp \
    --eval "(ql:quickload :swank)" \
    --eval "(require :swank)" \
    --eval "(setq swank::*loopback-interface* \"0.0.0.0\")" \
    --eval "(swank:create-server :port 4005 :dont-close t)" \
    "$@" \
    --eval "(sleep 315360000000)"

exec "$@"
