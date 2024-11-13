Simple reverse shell container image.

Testing:

```
docker compose build && docker compose up
docker compose exec -it server /attach.sh
```
