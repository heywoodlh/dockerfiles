FROM heywoodlh/powershell:latest
LABEL maintainer="heywoodlh"

# Install invoke-atomicredteam
RUN cd /root && Install-Module -Name invoke-atomicredteam,powershell-yaml -Scope CurrentUser -Force

# Install the atomics folder
RUN IEX (IWR 'https://raw.githubusercontent.com/redcanaryco/invoke-atomicredteam/master/install-atomicsfolder.ps1' -UseBasicParsing); Install-AtomicsFolder

VOLUME /root/AtomicRedTeam/atomics

# Set the default working directory
WORKDIR /root

ENTRYPOINT ["Invoke-AtomicTest"]
