Based on Alpine 3.17, latest Quicklisp and ASDF, exposing swank on port 4005.

Command `ccl` is install in /usr/local/bin, and on the `PATH`.
Quicklisp is installed in /opt.

This image has a default entrypoint that loads swank and sleep forever,
which is suitable as long running server.

To use the image to load addtional application and its startup function,
just provide in Dockerfile or docker compose a command as follows:

``` dockerfile

CMD ["--eval", "(ql:quickload :app-system)",
     "--eval", "(app:startup)"]

```
or

``` yaml

command: ["--eval", "(ql:quickload :app-system)",
          "--eval", "(app:startup)"]

```
or

``` shell

docker run -it tsanhwa/ccl --eval '(ql:quickload :app-system)'

```

To `quickload` additional system layering upon this image, use RUN such as:

``` dockerfile

RUN ccl \
    --load /opt/quicklisp/setup.lisp \
    --eval "(ql:quickload '(:hunchentoot))" \
    --eval "(quit)"

```

Notes
======

Clozure-Cl is made compatible with Alpine with [sgerrand glibc layer][1],
although its v2.34 doesn't work.

Also check a popular [glibc compatible Alpine docker][2] and its
[github repo][3].

Quicklisp is instaled in /opt so that local project can be easily mapped
between the container and host file system where project source repo is
symbolic linked to host's /opt.

[1]: https://github.com/sgerrand/alpine-pkg-glibc
[2]: https://hub.docker.com/r/frolvlad/alpine-glibc/
[3]: ttps://github.com/Docker-Hub-frolvlad/docker-alpine-glibc/
