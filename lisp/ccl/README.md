Based on Alpine 3.14, exposing swank on port 4005.


Start ccl
==========

Command `ccl` is on the `PATH`. You may start it like this:

	ccl --load ~/quicklisp/setup.lisp \
	    --eval "(ql:quickload :swank)" \
	    --eval "(require :swank)" \
	    --eval "(setq swank::*loopback-interface* \"0.0.0.0\")" \
	    --eval "(swank:create-server :port 4005 :dont-close t)"

or appended with `(loop)` when inside Dockerfile CMD

	CMD ccl --load ~/quicklisp/setup.lisp \
	    --eval "(ql:quickload :swank)" \
	    --eval "(require :swank)" \
	    --eval "(setq swank::*loopback-interface* \"0.0.0.0\")" \
	    --eval "(swank:create-server :port 4005 :dont-close t)"
	    --eval "(sleep 315360000000)"

Notes
======

Clozure-Cl is made compatible with Alpine with [glibc layer][1].

sgerrand v2.34 can't work with CCL.

[1]: https://github.com/sgerrand/alpine-pkg-glibc
