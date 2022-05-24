FROM alpine as staging

RUN apk --no-cache add git
RUN git clone https://github.com/thefinn93/signal-weechat /opt/signal-weechat

FROM heywoodlh/weechat
LABEL maintainer=heywoodlh

RUN apk --no-cache add py3-pip ca-certificates
RUN pip3 install qrcode
RUN apk del py3-pip


RUN mkdir -p /weechat/.weechat/python/
COPY --from=staging /opt/signal-weechat/signal.py /weechat/.weechat/python/signal.py
RUN chown -R weechat:weechat /weechat/.weechat

VOLUME /weechat

WORKDIR /weechat

EXPOSE 9001

ENTRYPOINT ["/run.sh"]
CMD ["--dir /weechat"]
