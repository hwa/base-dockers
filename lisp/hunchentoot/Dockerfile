FROM tsanhwa/ccl:1

RUN ccl \
    --load /opt/quicklisp/setup.lisp \
    --eval "(ql:quickload '(:hunchentoot))" \
    --eval "(quit)"

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
