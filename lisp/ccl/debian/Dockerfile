FROM debian:9

ENV cclver 1.11.5-linuxx86
ENV buildpkgs "curl build-essential"
ENV cclurl https://github.com/Clozure/ccl/releases/download/v1.11.5/ccl-${cclver}.tar.gz
ENV qlurl https://beta.quicklisp.org/quicklisp.lisp

RUN apt-get update && \
    apt-get install -y ${buildpkgs}
RUN curl -SL ${cclurl} | tar -xz
RUN curl -SOL ${qlurl}

RUN ln -s /ccl/lx86cl64 /usr/bin/ccl
RUN ccl --load quicklisp.lisp \
        --eval "(quicklisp-quickstart:install)" \
        --eval "(ql:quickload :swank)" \
        --eval "(quit)"

EXPOSE 4005
# CMD ccl --load ~/quicklisp/setup.lisp \
#         --eval "(ql:quickload :swank)" \
#         --eval "(require :swank)" \
#         --eval "(setq swank::*loopback-interface* \"0.0.0.0\")" \
#         --eval "(swank:create-server :port 4005 :dont-close t)"

