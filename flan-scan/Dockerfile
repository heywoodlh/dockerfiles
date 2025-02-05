FROM alpine:latest as build

RUN apk --no-cache add git \
	&& git clone https://github.com/cloudflare/flan /opt/flan

FROM python:3.9-alpine AS base
LABEL maintainer=heywoodlh

COPY --from=build /opt/flan/aws_push.py /
COPY --from=build /opt/flan/gcp_push.py /
COPY --from=build /opt/flan/output_report.py /
COPY --from=build /opt/flan/requirements.txt /
COPY --from=build /opt/flan/run.sh /
COPY --from=build /opt/flan/shared /shared
COPY --from=build /opt/flan/contrib /contrib

RUN apk add --no-cache nmap nmap-scripts git \
    && pip install --no-cache-dir -r requirements.txt \
    && git clone https://github.com/vulnersCom/nmap-vulners /usr/share/nmap/scripts/vulners \
    && nmap --script-updatedb \
    && apk del git \
    && chmod +x /run.sh

FROM base

ENTRYPOINT ["/bin/sh", "-c", "/run.sh"]
