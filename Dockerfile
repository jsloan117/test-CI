FROM alpine:latest
LABEL Name=hackmyresume Version=1.2
LABEL maintainer="Jonathan Sloan"

RUN echo "*** updating system ***" \
    && apk update && apk upgrade \
    && echo "*** installing packages ***" \
    && apk --no-cache add bash wkhtmltopdf nodejs npm \
    && echo "*** cleanup ***" \
    && rm -rf /tmp/* /var/tmp/*

RUN npm install -g \
    hackmyresume \
    jsonresume-theme-eloquent

WORKDIR /resumes

VOLUME [ "/resumes" ]

#ARG DEFAULT_THEME=/usr/lib/node_modules/jsonresume-theme-eloquent

CMD [ "hackmyresume" ]
