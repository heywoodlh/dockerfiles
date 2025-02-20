A tiny caddy web server that serves files in `/web`.

GitHub Action used to build the image: [http-files-buildx.yml](https://github.com/heywoodlh/actions/blob/master/.github/workflows/http-files-buildx.yml)

[Dockerfile](https://github.com/heywoodlh/dockerfiles/blob/master/http-files/Dockerfile)

## Usage:

```
docker run -it --rm -p 8080:80 -v $(pwd)/test:/web docker.io/heywoodlh/http-files
```
