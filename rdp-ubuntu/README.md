## rdp-ubuntu

This image is a basic Ubuntu image, with XRDP installed and enabled by default. It is intended to be used as a base where a graphical environment accessed via RDP would be used.

### Usage:

```
docker run -it --rm \
    --name rdp-ubuntu \
    -e USER=ubuntu \ # Required if you want to be able to login via RDP/SSH
    -e PASSWORD=ubuntu \ # Optional: default password is 'ubuntu' if $USER is set
    -e SSHD_ENABLE=true \ # Optional: make sure to expose the SSH port
    -p 3389:3389 \ # Connect to this port with an RDP client
    -p 2222:22 \ # Connect to this port with an SSH client
    heywoodlh/rdp-ubuntu
```


### Using this image as a base:

If you want to use this image as a base and install extra packages, an example Dockerfile might look like this:

```
FROM heywoodlh/rdp-ubuntu

RUN apt-get update \
    && DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
	nmap \
	gnupg \
	pass

## Do other stuff

## Cleanup
RUN apt-get autoremove -y &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/*

```

I would recommend not messing with the `ENTRYPOINT` or `CMD`. If you want to do that, I would recommend using the assets for the image as a resource to build your own image: https://github.com/heywoodlh/dockerfiles/tree/master/rdp-ubuntu
