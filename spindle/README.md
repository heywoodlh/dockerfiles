Community image of [Spindle](https://docs.tangled.org/spindles), [tangled.org](https://tangled.org)'s CI runner.

Features:
- Unprivileged user
- Docker in Docker configuration
- [spindle-run](https://tangled.org/heywoodlh.io/spindle-run) installed for ease of testing in container

---

Dockerfile: https://tangled.org/heywoodlh.io/dockerfiles/blob/main/spindle/Dockerfile

Pipeline definition to build and push the image: https://tangled.org/heywoodlh.io/dockerfiles/blob/main/.tangled/workflows/spindle.yml

Docker Hub image: [heywoodlh/spindle](https://hub.docker.com/r/heywoodlh/spindle)

## Docker-Compose

See [docker-compose.yml](https://tangled.org/heywoodlh.io/dockerfiles/tree/main/spindle)

## Deploy on Fly.io

See [fly.io assets](https://tangled.org/heywoodlh.io/dockerfiles/tree/main/spindle)

```
fly launch
```

## Kubernetes

See [spindle.yaml](https://tangled.org/heywoodlh.io/nixos-configs/blob/main/flakes/kube/manifests/spindle.yaml)
