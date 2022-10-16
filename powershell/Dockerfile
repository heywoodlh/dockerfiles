FROM heywoodlh/trizen
LABEL maintainer=heywoodlh

RUN trizen -Sy --noconfirm powershell-bin \
    && trizen -Scc 

USER root

RUN userdel -r trizen

ENTRYPOINT [ "/usr/bin/pwsh" ]
