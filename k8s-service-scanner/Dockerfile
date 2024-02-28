FROM docker.io/bitnami/kubectl:latest
LABEL MAINTAINER="heywoodlh"

USER root
RUN mkdir -p /out && chown -R 1001 /out
VOLUME /out

COPY services.sh /entrypoint
USER 1001

ENTRYPOINT ["/entrypoint", "|", "sort", "-u", "|", "tee", "/out/services.txt"]
