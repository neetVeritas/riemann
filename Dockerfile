FROM neetjn/crusty-box:latest

MAINTAINER John Nolette, john@neetgroup.net

ENV RIEMANN_VERSION 0.2.11
RUN curl -skL https://aphyr.com/riemann/riemann-${RIEMANN_VERSION}.tar.bz2 | bunzip2 | tar -x && \
    mv /riemann-${RIEMANN_VERSION} /riemann

COPY riemann.config /etc/riemann/

EXPOSE 5555 5556

CMD ["start"]
ENTRYPOINT ["riemann"]