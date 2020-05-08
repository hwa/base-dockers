FROM debian:9

ENV buildpkgs="python ipython python-pip"

RUN apt-get update && \
        apt-get install -y --no-install-recommends ${buildpkgs}
