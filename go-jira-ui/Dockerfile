FROM golang:buster as builder

RUN apt-get update && apt-get install -y git

# workaround for https://github.com/mikepea/go-jira-ui/issues/57
RUN go get -v gopkg.in/gizak/termui.v2 || :
RUN cd $GOPATH/src/gopkg.in/gizak/termui.v2 &&\
	git checkout v3.0.0 &&\
	go get -v github.com/mikepea/go-jira-ui/jira-ui

FROM debian
LABEL maintainer=heywodlh

RUN apt-get update && apt-get install -y pass vim &&\
	rm -rf /var/lib/apt/lists/*

COPY --from=builder /go/bin/* /usr/local/bin/

RUN useradd -ms /bin/bash jira
RUN passwd -d jira
RUN passwd -d root

RUN ln -s /usr/bin/pinentry* /usr/local/bin/

USER jira
WORKDIR /home/jira

ENTRYPOINT "jira-ui"
