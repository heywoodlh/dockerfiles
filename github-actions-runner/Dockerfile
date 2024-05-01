FROM ubuntu:24.04
ENV DEBIAN_FRONTEND=noninteractive

# add docker user
RUN useradd -m docker
RUN mkdir -p /etc/sudoers.d && echo 'docker ALL=(ALL) NOPASSWD:ALL' | tee -a /etc/sudoers.d/docker

# install all desired packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
      sudo ca-certificates curl nodejs wget unzip vim git jq build-essential libssl-dev libffi-dev python3 python3-venv python3-dev python3-pip \
    && install -m 0755 -d /etc/apt/keyrings \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc \
    && chmod a+r /etc/apt/keyrings/docker.asc \
    && echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && apt-get update \
    && apt-get install -y --no-install-recommends docker-ce-cli \
    && usermod -aG docker docker \
    && rm -rf /var/lib/apt/lists/*

# install actions runner bundle
WORKDIR /home/docker
RUN mkdir actions-runner && cd actions-runner \
    && export arch="$(dpkg --print-architecture)" \
    && /usr/bin/[ ${arch} == "amd64" ] && export runner_arch="x64" || true \
    && /usr/bin/[ ${arch} == "arm64" ] && export runner_arch="arm64" || true \
    && export runner_version=$(curl -s https://api.github.com/repos/actions/runner/releases/latest | jq -r '.name' | sed 's/^v//g') \
    && echo "${runner_version}" > /version \
    && curl -s -o ./actions-runner.tar.gz -L https://github.com/actions/runner/releases/download/v${runner_version}/actions-runner-linux-${runner_arch}-${runner_version}.tar.gz \
    && tar xzf ./actions-runner.tar.gz \
    && chown -R docker ~docker \
    && apt-get update \
    && /home/docker/actions-runner/bin/installdependencies.sh \
    && rm -rf /var/lib/apt/lists/*

COPY scripts/start.sh start.sh
RUN chmod +x start.sh

USER docker

ENTRYPOINT ["./start.sh"]
