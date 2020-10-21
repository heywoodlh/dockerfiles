FROM alpine

MAINTAINER "heywoodlh"


RUN useradd -ms /bin/bash pass
RUN passwd -d pass

RUN apk --no-cache add pass gnupg pinentry

USER pass
WORKDIR /home/pass
CMD ["pass"]
