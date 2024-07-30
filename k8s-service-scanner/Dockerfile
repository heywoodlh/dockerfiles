FROM docker.io/bitnami/kubectl:latest
LABEL MAINTAINER="heywoodlh"

USER root
RUN mkdir -p /out && chown -R 1001 /out
VOLUME /out

COPY services.sh /entrypoint
COPY version /version
USER 1001
ENV EXTRA_TARGETS=""

ENTRYPOINT ["/entrypoint", "|", "sort", "-u", "|", "tee", "/out/services.txt"]
