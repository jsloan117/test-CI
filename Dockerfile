FROM alpine:latest
LABEL Name=test-CI Version=0.3
LABEL maintainer="Jonathan Sloan"

RUN echo "*** updating system ***" \
    && apk update \
    && echo "*** installing packages ***" \
    && apk --no-cache add bash \
    && echo "*** cleanup ***" \
    && rm -rf /tmp/* /var/tmp/*

ADD scripts/hello-world.sh /
RUN chmod +x /hello-world.sh

CMD [ "bash", "/hello-world.sh" ]
