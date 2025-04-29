FROM docker.io/alpine:latest

RUN apk --no-cache add vim nano bind-tools \
    && apk --no-cache add --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community kubectl k9s helm kustomize

ENTRYPOINT [ "/bin/ash" ]
