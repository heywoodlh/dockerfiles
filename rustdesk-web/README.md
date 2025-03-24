This is an image with the Rustdesk desktop client installed on a Linux desktop, made accessible via KasmWeb.

The Dockerfile and build assets for this image is here: [rustdesk-web](https://github.com/heywoodlh/dockerfiles/tree/master/rustdesk-web)

The GitHub Action used to create the image is here: [rustdesk-web-buildx.yml](https://github.com/heywoodlh/actions/blob/master/.github/workflows/rustdesk-web-buildx.yml)

# Usage

```
docker run -it --rm -e VNC_PW=password -p 6901:6901 docker.io/heywoodlh/rustdesk-web
```

Once running, the application should be available at `https://localhost:6901` with the following credentials: `kasm_user:password`

# Attribution

Largely based on [JReming85's Rustdesk kasm image](https://github.com/JReming85/rustdesk-kasm-image).
