FROM alpine:3.5

RUN echo "*** updating system ***" \
    && apk update \
    && echo "*** installing packages ***" \
    && apk --no-cache add bash \
    && echo "*** cleanup ***" \
    && rm -rf /tmp/* /var/tmp/*

COPY scripts/hello-world.sh /
RUN chmod +x /hello-world.sh

CMD [ "bash", "/hello-world.sh" ]
