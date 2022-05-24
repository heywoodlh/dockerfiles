FROM heywoodlh/gitleaks
LABEL MAINTAINER=heywoodlh

USER root
RUN apk --no-cache add github-cli grep jq

ADD ./github-leaks.sh /usr/local/bin/github-leaks.sh
RUN chmod 755 /usr/local/bin/github-leaks.sh

USER gitleaks
ENTRYPOINT ["github-leaks.sh"]
