Based on Debian 9, exposing swank on port 4005.


* start sbcl

Command `sbcl` is on the `PATH`. You may start it like this:
	sbcl --load ~/quicklisp/setup.lisp \
	    --eval "(ql:quickload :swank)" \
	    --eval "(require :swank)" \
	    --eval "(setq swank::*loopback-interface* \"0.0.0.0\")" \
	    --eval "(swank:create-server :port 4005 :dont-close t)"

or appended with `(loop)` when inside Dockerfile CMD
	CMD sbcl --load ~/quicklisp/setup.lisp \
	    --eval "(ql:quickload :swank)" \
	    --eval "(require :swank)" \
	    --eval "(setq swank::*loopback-interface* \"0.0.0.0\")" \
	    --eval "(swank:create-server :port 4005 :dont-close t)"
	    --eval "(loop)"

