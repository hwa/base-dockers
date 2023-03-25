FROM tsanhwa/ccl:1.1

RUN ccl \
    --load /opt/quicklisp/setup.lisp \
    --eval "(ql:quickload '(:hunchentoot))" \
    --eval "(quit)"
