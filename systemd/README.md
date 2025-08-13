Multi-arch, multi-operating-system images with systemd.

Dockerfiles and build script defined here: https://github.com/heywoodlh/dockerfiles/tree/master/systemd

## Usage

Use like so:

```
docker run -it --rm --privileged docker.io/heywoodlh/systemd:ubuntu bash
```

Any arguments that you'd like to pass to systemd can be passed via the `ARGS` environment variable, like so:

```
# Make systemd output a lot quieter
docker run -it --rm --privileged -e ARGS="--log-level=emerg" docker.io/heywoodlh/systemd:ubuntu bash
```

# Credit

https://github.com/AkihiroSuda/containerized-systemd
