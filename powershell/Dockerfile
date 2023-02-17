## Figure out how to get Powershell latest version number
FROM ubuntu:latest AS download

RUN apt-get update \
    && apt-get install -y curl jq \
    && rm -rf /var/lib/apt/lists/*

## Script parses latest Powershell version and downloads it
COPY download.sh /download.sh
RUN /download.sh 

FROM ubuntu:latest
LABEL maintainer=heywoodlh

## Dependencies for Powershell
RUN apt-get update && apt-get install --no-install-recommends -y \
    ca-certificates \
    less \
    terminfo \
    curl \
    libcurl4 \
    libicu71 \
    libssl3 \
    liblttng-ust1 \
    libunwind8 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=download /opt/microsoft/powershell /opt/microsoft/powershell

## Symlink
RUN ln -s /opt/microsoft/powershell/*/pwsh /usr/bin/pwsh

ENTRYPOINT [ "/usr/bin/pwsh" ]
