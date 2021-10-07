FROM debian:11

ENV cclver 1.12.1
ENV buildpkgs "busybox ca-certificates"
ENV CCL_TAR_GZ "ccl-${cclver}-linuxx86.tar.gz"
ENV cclurl https://github.com/Clozure/ccl/releases/download/v${cclver}/${CCL_TAR_GZ}
ENV qlurl https://beta.quicklisp.org/quicklisp.lisp

RUN apt-get update && \
    apt-get install -y ${buildpkgs} && \
    apt-get clean

RUN busybox wget ${cclurl} && \
    tar zxf ${CCL_TAR_GZ} && \
    mkdir /opt/ccl && cp ./ccl/lx86cl64* /opt/ccl/ && \
    rm -rf ./ccl ${CCL_TAR_GZ} && \
    ln -s /opt/ccl/lx86cl64 /usr/local/bin/ccl

RUN busybox wget ${qlurl} && \
    ccl --load quicklisp.lisp \
        --eval "(quicklisp-quickstart:install)" \
        --eval "(ql:quickload :swank)" \
        --eval "(quit)" && \
    rm quicklisp.lisp

EXPOSE 4005
# CMD ccl --load ~/quicklisp/setup.lisp \
#         --eval "(ql:quickload :swank)" \
#         --eval "(require :swank)" \
#         --eval "(setq swank::*loopback-interface* \"0.0.0.0\")" \
#         --eval "(swank:create-server :port 4005 :dont-close t)"
