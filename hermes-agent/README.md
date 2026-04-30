A [Hermes Agent](https://github.com/NousResearch/hermes-agent) image with the following features:
- hermes-agent installation at `/opt/hermes`
- TTYD for web-based shell interaction
- Nix installed
- Running as unprivileged `nix` user
- Podman installed and configured for rootless use for `nix` user
- Supervisord installed and configured to be extended (i.e. add new service definitions to `/etc/supervisord/conf.d/*.conf`)

Dockerfile and build resources are here: https://github.com/heywoodlh/dockerfiles/tree/master/claude-code-webui

GitHub Action to build this on a recurring basis: https://github.com/heywoodlh/actions/blob/master/.github/workflows/claude-code-webui.yml

## Deployment

Example `docker-compose.yml`:

```yaml
services:
  hermes-agent:
    image: docker.io/heywoodlh/hermes-agent:latest
    ports:
      - "8080:8080"
    restart: unless-stopped
    volumes:
      - ./nix:/nix
      - ./home:/home/nix
      - ./supervisord-custom:/etc/supervisor/conf.d
    #environment:
    #  - HTTP_AUTH_USERNAME=admin
    #  - HTTP_AUTH_PASSWORD=
```

## Basic Auth

Optional HTTP basic auth can be enabled by setting both environment variables:

| Variable | Default | Description |
|----------|---------|-------------|
| `HTTP_AUTH_USERNAME` | `admin` | Username for basic auth |
| `HTTP_AUTH_PASSWORD` | _(empty)_ | Password for basic auth — auth is **disabled** if this is empty |

When `HTTP_AUTH_PASSWORD` is set to a non-empty value, ttyd will use basic auth
