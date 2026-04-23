Simple reverse shell container image.

## Server deployment

Server deployment, using Docker-compose:

```
services:
  server:
    hostname: server
    image: docker.io/heywoodlh/reverse-shell:server
    restart: unless-stopped
    ports:
      - 1337:1337
    environment:
      - LISTEN_PORT=1337
    volumes:
      - ssl:/ssl/

volumes:
  ssl:
```

## Client deployment

```
docker run --network=host -it --rm -e SERVER_ADDRESS="localhost" -e SERVER_PORT="1337" docker.io/heywoodlh/reverse-shell:client
```

## Kubernetes deployment

See below for reference client and server deployment in Kubernetes:

<details>
```
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: reverse-shell-client
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: reverse-shell-client
  template:
    metadata:
      labels:
        app: reverse-shell-client
    spec:
      containers:
        - env:
            - name: SERVER_ADDRESS
              value: "reverse-shell-server.default.svc.cluster.local"
            - name: SERVER_PORT
              value: "1337"
          image: docker.io/heywoodlh/reverse-shell:client
          name: reverse-shell-client
      hostname: reverse-shell-client
      restartPolicy: Always
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: reverse-shell-server
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: reverse-shell-server
  template:
    metadata:
      labels:
        app: reverse-shell-server
    spec:
      containers:
        - env:
            - name: LISTEN_PORT
              value: "1337"
          image: docker.io/heywoodlh/reverse-shell:server
          name: reverse-shell-server
          ports:
            - name: socat
              containerPort: 1337
              protocol: TCP
      hostname: reverse-shell-server
      restartPolicy: Always
---
apiVersion: v1
kind: Service
metadata:
  name: reverse-shell-server
  namespace: default
spec:
  selector:
    app: reverse-shell-server
  ports:
  - name: socat
    port: 1337
    targetPort: 1337
    protocol: TCP
  type: ClusterIP
```
</details>

## Enable SSL

Set the following environment variable to enable SSL on the server and client:

```
ENABLE_SSL=true
```

Like so for the server:

```
services:
  server:
    hostname: server
    image: docker.io/heywoodlh/reverse-shell:server
    restart: unless-stopped
    ports:
      - 1337:1337
    environment:
      - LISTEN_PORT=1337
      - SSL_CERT=/ssl/cert.pem
      - SSL_KEY=/ssl/key.pem
      - ENABLE_SSL=true
```

Then connect to the server like so:

```
docker run --network=host -it --rm -e ENABLE_SSL=true -e SERVER_ADDRESS="localhost" -e SERVER_PORT="1337" docker.io/heywoodlh/reverse-shell:client
```

### Generate a custom SSL certificate

Generate a certificate like so:

```
mkdir -p ssl
openssl req -newkey rsa:4096 -nodes -keyout ssl/key.pem -x509 -days 1000 -subj '/CN=reverse-shell/O=Reverse Shell, Inc./C=US' -out ssl/cert.pem
```

Then use the certificate directory as a volume mounted at `/ssl`.

## Extra notes

The client image runs as root with the following additional packages:
- `apk` and `nix` available for installing additional packages.
- `kubectl` for interfacing with a Kubernetes cluster if deployed
- `docker` client for interfacing with Docker daemon

## Testing

```
docker compose build && docker compose up
docker compose exec -it server /attach.sh
```


