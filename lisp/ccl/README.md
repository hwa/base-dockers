Based on Alpine 3.14, latest Quicklisp and ASDF, exposing swank on port 4005.

Command `ccl` is install in /usr/local/bin, and on the `PATH`.
Quicklisp is installed in /opt.


Start ccl
==========

Command `ccl` is on the `PATH`. You may start it like this:

	ccl --load ~/quicklisp/setup.lisp \
	    --eval "(ql:quickload :swank)" \
	    --eval "(require :swank)" \
	    --eval "(setq swank::*loopback-interface* \"0.0.0.0\")" \
	    --eval "(swank:create-server :port 4005 :dont-close t)"

or appended with `(sleep)` when inside Dockerfile CMD

	CMD ccl --load ~/quicklisp/setup.lisp \
	    --eval "(ql:quickload :swank)" \
	    --eval "(require :swank)" \
	    --eval "(setq swank::*loopback-interface* \"0.0.0.0\")" \
	    --eval "(swank:create-server :port 4005 :dont-close t)"
	    --eval "(sleep 315360000000)"

Notes
======

Clozure-Cl is made compatible with Alpine with [sgerrand glibc layer][1],
although its v2.34 doesn't work.

Also check a popular [glibc compatible Alpine docker][2].

[1]: https://github.com/sgerrand/alpine-pkg-glibc
[2]: https://hub.docker.com/r/frolvlad/alpine-glibc/
