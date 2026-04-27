This is a community, multiarch, built-from-source image of the Metasploit Framework.

Features:
- Unprivileged `msf` user
- Built-from-source Metasploit
- Nix package manager installed for additional post-installation packages
- `msfrpcd` and `msfd` tag for running Metasploit remotely: [Running Metasploit Remotely](https://docs.rapid7.com/metasploit/running-metasploit-remotely/)

### Resources

The Dockerfile for this image is here: https://github.com/heywoodlh/dockerfiles/blob/master/metasploit/Dockerfile

The GitHub Action to build this image is here: https://github.com/heywoodlh/actions/blob/master/.github/workflows/metasploit-buildx.yml

Includes the [Nix package manager](https://nixos.org/download/) for any optional dependencies that might be desired after deployment.

### Docker Compose

The following should serve as a reference for every type of deployment desired: [docker-compose.yml](https://github.com/heywoodlh/dockerfiles/blob/master/metasploit/docker-compose.yml)

As a quickstart, copy [docker-compose.yml](https://github.com/heywoodlh/dockerfiles/blob/master/metasploit/docker-compose.yml) to your project directory:

Then, to run Metasploit with a working database, run:

```
docker compose run --rm metasploit
```

If you'd like to try Metasploit client with a separate `msrpcd` instance and database, run:

```
docker compose run --rm msfrpc
```

If you'd like to try a Netcat client with `msfd` with a separate `msfd` instance and database, run:

```
docker compose run --rm msfd-client
```

Bring down all services when done with:

```
docker compose down
```

## Issues

If issues are encountered with this image [feel free to open an issue](https://github.com/heywoodlh/dockerfiles/issues/new).
