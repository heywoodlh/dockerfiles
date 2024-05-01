#!/bin/bash

# Useful docs:
# https://baccini-al.medium.com/how-to-containerize-a-github-actions-self-hosted-runner-5994cc08b9fb
# https://testdriven.io/blog/github-actions-docker/

GH_OWNER="${GH_OWNER}"
GH_REPOSITORY="${GH_REPO}"
# personal access token with following permissions: manage_runners:org, read:org, repo, workflow
GH_TOKEN="${GH_TOKEN}"

RUNNER_SUFFIX=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 5 | head -n 1)
RUNNER_NAME="docker-${RUNNER_SUFFIX}"

cd /home/docker/actions-runner

# Issue token to self and initialize runner in repository
REG_TOKEN=$(curl -L -X POST -H "Accept: application/vnd.github+json" -H "Authorization: Bearer ${GH_TOKEN}" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/repos/${GH_OWNER}/${GH_REPO}/actions/runners/registration-token | jq .token --raw-output)

/home/docker/actions-runner/config.sh --url https://github.com/${GH_OWNER}/${GH_REPO} --token ${REG_TOKEN}

# Will remove self when container is destroyed
cleanup() {
    echo "Removing runner..."
    /home/docker/actions-runner/config.sh remove --unattended --token ${REG_TOKEN}
}
trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

/home/docker/actions-runner/run.sh & wait $!
