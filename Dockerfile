FROM alpine:3

RUN echo "*** updating system ***" \
    && apk update \
    && echo "*** installing packages ***" \
    && apk --no-cache add bash \
    && echo "*** cleanup ***" \
    && rm -rf /tmp/* /var/tmp/*

ADD scripts/hello-world.sh /
RUN chmod +x /hello-world.sh

LABEL org.opencontainers.image.title=
LABEL org.opencontainers.image.description=
LABEL org.opencontainers.image.documentation=http://jsloan117.github.io/test-CI
LABEL org.opencontainers.image.url=
LABEL org.opencontainers.image.source=
LABEL org.opencontainers.image.version=
LABEL org.opencontainers.image.created=
LABEL org.opencontainers.image.revision=
LABEL org.opencontainers.image.licenses=

CMD [ "bash", "/hello-world.sh" ]
