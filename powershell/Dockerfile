FROM heywoodlh/trizen
LABEL maintainer=heywoodlh

RUN trizen -Sy --noconfirm powershell-bin \
    && trizen -Scc

ENTRYPOINT [ "/usr/bin/pwsh" ]
