FROM debian:9

ENV buildpkgs "sbcl curl build-essential"
RUN apt-get update
RUN apt-get install -y --no-install-recommends ${buildpkgs}

RUN curl -O http://beta.quicklisp.org/quicklisp.lisp

RUN sbcl --load quicklisp.lisp \
        --eval "(quicklisp-quickstart:install)" \
        --eval "(ql:quickload :swank)" \
        --eval "(quit)"

EXPOSE 4005

# CMD sbcl --load ~/quicklisp/setup.lisp \
#         --eval "(ql:quickload :swank)" \
#         --eval "(require :swank)" \
#         --eval "(setq swank::*loopback-interface* \"0.0.0.0\")" \
#         --eval "(swank:create-server :port 4005 :dont-close t)"
