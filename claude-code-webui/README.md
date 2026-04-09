A [Claude Code WebUI](https://github.com/sugyan/claude-code-webui) image with the following features:
- Determinate Nix installed
- Claude Code installed
- Running as unprivileged `nix` user
- Podman installed and configured for rootless use for `nix` user

Dockerfile and build resources are here: https://github.com/heywoodlh/dockerfiles/tree/master/claude-code-webui

GitHub Action to build this on a recurring basis: https://github.com/heywoodlh/actions/blob/master/.github/workflows/claude-code-webui.yml

## Deployment

Example `docker-compose.yml`:

```yaml
services:
  claude-code-webui:
    image: docker.io/heywoodlh/claude-code-webui:latest
    ports:
      - "8080:8080"
    restart: unless-stopped
    volumes:
      - ./nix:/nix
      - ./home:/home/nix
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

When `HTTP_AUTH_PASSWORD` is set to a non-empty value, nginx will require credentials before proxying to the WebUI.

## Claude Code configuration

Initial configuration should be done by exec-ing into the container and running `claude`, like so:

```bash
docker compose exec claude-code-webui claude
```
