This is a community, multiarch build of the Metasploit Framework using [the Nightly installer](https://docs.metasploit.com/docs/using-metasploit/getting-started/nightly-installers.html).

Features:
- Unprivileged `msf` user
- Built-from-source Metasploit
- Nix package manager installed for additional post-installation packages

### Resources

The Dockerfile for this image is here: https://github.com/heywoodlh/dockerfiles/blob/master/metasploit/Dockerfile

The GitHub Action to build this image is here: https://github.com/heywoodlh/actions/blob/master/.github/workflows/metasploit-buildx.yml

Includes the [Determinate Nix package manager](https://determinate.systems/nix/) for any optional dependencies that might be desired after deployment.

### Docker Compose

```
services:
  # Run with: docker compose run --rm metasploit
  metasploit:
    image: "docker.io/heywoodlh/metasploit:latest"
    command: "msfconsole --quiet --execute-command 'db_connect postgres:msf@db:5432/msf'"
    tty: true
    stdin_open: true
    volumes:
      - msf_data:/home/msf/.msf4
      - msf_nix:/nix
    ports:
      - 1337:1337 # C&C port
    links:
      - db
    #environment:
    #  SUDO: "true" # uncomment for `msf` user to be able to run `sudo` commands
  db:
    image: "docker.io/postgres:14"
    volumes:
      - msf_database:/var/lib/postgresql/data
    environment:
      POSTGRES_DB: msf
      POSTGRES_PASSWORD: msf

volumes:
  msf_database:
  msf_data:
  msf_nix:
```

Then

```
docker compose run --rm metasploit
```

## Issues

If issues are encountered with this image [feel free to open an issue](https://github.com/heywoodlh/dockerfiles/issues/new).
