A [Claude Code WebUI](https://github.com/sugyan/claude-code-webui) image with the following features:
- Determinate Nix installed
- Claude Code installed
- Running as unprivileged `nix` user

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
```

## Claude Code configuration

Initial configuration should be done by exec-ing into the container and running `claude`, like so:

```bash
docker compose exec claude-code-webui claude
```
