Determinate Nix image with Flakes enabled by default.

Dockerfile and build resources are here: https://github.com/heywoodlh/dockerfiles/tree/master/nix

GitHub Action to build this on a recurring basis: https://github.com/heywoodlh/actions/blob/master/.github/workflows/nix-buildx.yml

## Usage

```
docker run -it --rm docker.io/heywoodlh/nix:latest nix run nixpkgs#hello
```

### Statically linked Lix

The nixStatic package is a bit neglected, see [Build failure: nixStatic (bash: Argument list too long)](https://github.com/NixOS/nixpkgs/issues/357949). This image also provides a statically linked [Lix](https://lix.systems) target that should serve as a drop-in replacement for Nix.

Use these tags for an image with statically linked Lix:
- `docker.io/heywoodlh/nix:lix`
- `docker.io/heywoodlh/nix:lix-${version}`

### Statically linked Nix

There is also a static Nix image with the `static` tag:

```
docker run -it --rm docker.io/heywoodlh/nix:static nix run nixpkgs#hello
```

The `static` image can be used as a base to redistribute the static Nix binary for other Linux systems, as well:

```
mkdir -p /tmp/nix-bin
docker run -it --rm -v /tmp/nix-bin:/tmp/nix-bin docker.io/heywoodlh/nix:static cp /usr/bin/nix /tmp/nix-bin/nix
/tmp/nix-bin/nix --version
```

<details>
Here is a more detailed example of using the statically compiled `nix` binary against Docker containers:

```
# Grab the nix static binary
mkdir -p /tmp/nix-bin
docker run -it --rm -v /tmp/nix-bin:/tmp/nix-bin docker.io/heywoodlh/nix:static cp /usr/bin/nix /tmp/nix-bin/nix

# Run background container to test (install ca-certificates for nix, though)
docker run -d --rm --entrypoint=bash --name=ubuntu-test ubuntu -c "apt update && apt install -y ca-certificates && sleep 36000"

# Copy nix over, because Docker wasn't letting me execute the binary from mount
docker cp /tmp/nix-bin/nix ubuntu-test:/tmp/nix

# Sleep for 10 seconds to let ca-certificates get installed
echo "sleeping for 10 seconds"
sleep 10

# Run nix in container
docker exec -it ubuntu-test /tmp/nix --extra-experimental-features "nix-command flakes" run nixpkgs#hello

# Clean up
docker rm -f ubuntu-test
cd; rm -rf /tmp/dockerfiles
```
</details>
