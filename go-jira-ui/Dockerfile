FROM golang:alpine

RUN apk --no-cache add git shadow pass vim

# workaround for https://github.com/mikepea/go-jira-ui/issues/57
RUN go get -v gopkg.in/gizak/termui.v2 || :
RUN cd $GOPATH/src/gopkg.in/gizak/termui.v2 &&\
	git checkout v3.0.0 &&\
	go get -v github.com/mikepea/go-jira-ui/jira-ui

RUN useradd -ms /bin/bash jira
RUN passwd -d jira
RUN passwd -d root

RUN apk del shadow

USER jira
WORKDIR /home/jira

ENTRYPOINT "jira-ui"
