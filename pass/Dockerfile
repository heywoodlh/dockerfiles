FROM alpine

MAINTAINER "heywoodlh"

RUN apk --no-cache add pass gnupg pinentry
RUN ln -s /usr/bin/* /usr/local/bin/

WORKDIR /root
CMD ["pass"]
