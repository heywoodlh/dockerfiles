# davmail

This image runs DavMail in a KasmWeb container.

GitHub Action used to build the image: [davmail.yml](https://github.com/heywoodlh/actions/blob/main/.github/workflows/davmail.yml)

[Dockerfile](https://tangled.org/heywoodlh.io/dockerfiles/blob/main/davmail/Dockerfile)

# docker-compose.yml

```
services:
  davmail:
    image: docker.io/heywoodlh/davmail:latest
    ports:
      - "3000:3000"   # KasmVNC web UI
      - "1025:1025"   # SMTP
      - "1110:1110"   # POP3
      - "1143:1143"   # IMAP
      - "1389:1389"   # LDAP
      - "1080:1080"   # CalDAV/CardDAV
    volumes:
      - config:/config
volumes:
  config:
```

# DavMail GUI

Access the DavMail GUI via KasmVNC at port 3000.
