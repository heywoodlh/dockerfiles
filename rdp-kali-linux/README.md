## rdp-kali-linux

This image is based on the official Kali Linux image, with XRDP installed and enabled by default.

### Usage:

```
docker run -it --rm \
    --name rdp-kali \
    -e USER=kali \ # Required if you want to be able to login via RDP/SSH
    -e PASSWORD=kali \ # Optional: default password is 'attacker' if $USER is set
    -e SSHD_ENABLE=true \ # Optional: make sure to expose the SSH port
    -e MSF_ENABLE=true \ # If true, Metasploit will be installed and Postgres will be setup for Metasploit to use (give the container time to install and setup)
    -p 3389:3389 \ # Connect to this port with an RDP client
    -p 2222:22 \ # Connect to this port with an SSH client
    heywoodlh/rdp-kali-linux
```


### Using this image as a base:

If you want to use this image as a base and install extra packages, an example Dockerfile might look like this:

```
FROM heywoodlh/rdp-kali-linux

RUN apt-get update \
    && DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
	metasploit-framework \
	kali-linux-headless \
	dnswalk \
	medusa \
	ndiff

```

I would recommend not messing with the `ENTRYPOINT` or `CMD`. If you want to do that, I would recommend using the assets for the image as a resource to build your own image: https://github.com/heywoodlh/dockerfiles/tree/master/rdp-kali-linux
