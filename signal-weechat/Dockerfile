FROM alpine as staging

RUN apk --no-cache add git
RUN git clone https://github.com/thefinn93/signal-weechat /opt/signal-weechat

FROM heywoodlh/weechat
LABEL maintainer=heywoodlh

RUN apk --no-cache add py3-pip
RUN pip3 install qrcode
RUN apk del py3-pip


USER weechat
RUN mkdir -p /weechat/.weechat/python/
COPY --from=staging /opt/signal-weechat/signal.py /weechat/.weechat/python/signal.py

VOLUME /weechat

WORKDIR /weechat

EXPOSE 9001

ENTRYPOINT ["/run.sh"]
CMD ["--dir /weechat"]
