FROM heywoodlh/powershell:latest
LABEL maintainer="heywoodlh"

# Install atomic tests dependences
RUN apt-get update &&\
    apt-get install -y at ccrypt clang cron curl ed g++ gcc golang iproute2 iputils-ping kmod libpam0g-dev less lsof make netcat-traditional net-tools nmap p7zip python2 rsync samba selinux-utils ssh sshpass sudo tcpdump telnet tor ufw vim whois zip &&\
    rm -rf /var/lib/apt/lists/*

# Install invoke-atomicredteam
RUN cd /root && pwsh -c 'Install-Module -Name invoke-atomicredteam,powershell-yaml -Scope CurrentUser -Force'

# Install the atomics folder
RUN pwsh -c 'IEX (IWR "https://raw.githubusercontent.com/redcanaryco/invoke-atomicredteam/master/install-atomicsfolder.ps1" -UseBasicParsing); Install-AtomicsFolder'

VOLUME /root/AtomicRedTeam/atomics

# Set the default working directory
WORKDIR /root

ENTRYPOINT ["pwsh", "-c"]
