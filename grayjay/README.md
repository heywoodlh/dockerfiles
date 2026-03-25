Unofficial [Grayjay](https://github.com/futo-org/grayjay.Desktop) Docker container image.

GitHub Action for building is here: https://github.com/heywoodlh/actions/blob/master/.github/workflows/grayjay.yml

Example compose file:

```
services:
  grayjay:
    image: docker.io/heywoodlh/grayjay:latest
    ports:
      - "11338:11338"
      - "11339:11339"
      - "11340:11340"
    restart: unless-stopped
    volumes:
      - ./data:/data
```

After the container comes up, the web UI should be accessible via http://localhost:11338/web.
