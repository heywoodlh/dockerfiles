Compile cachyos-wine with Ubuntu 24.04 in Docker:

```
git clone https://github.com/heywoodlh/dockerfiles /tmp/dockerfiles

cd /tmp/dockerfiles/wine-build
docker build -t wine-build .

docker run -it --rm -v /tmp/wine-cachyos:/opt/wine-cachyos wine-build
```
