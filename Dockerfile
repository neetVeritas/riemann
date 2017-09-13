FROM neetjn/crusty-box:latest

MAINTAINER John Nolette, john@neetgroup.net

ENV RIEMANN_VERSION 0.2.10
RUN curl -skL https://aphyr.com/riemann/riemann-${RIEMANN_VERSION}.tar.bz2 | bunzip2 | tar -x && \
    mv /riemann-${RIEMANN_VERSION} /app

WORKDIR /app

## hack shell wrapper to use busybox sh
RUN sed -ie 's/env bash/env sh/' bin/riemann

## hack default config to listen on all interfaces
RUN sed -ie 's/127.0.0.1/0.0.0.0/' etc/riemann.config

EXPOSE 5555/tcp 5555/udp 5556

CMD [ "bin/riemann", "etc/riemann.config" ]