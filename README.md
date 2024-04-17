# postgresapi

-- https://github.com/PostgREST/postgrest/discussions/3080

``` bash
podman pod create --name PostgREST
podman pull postgres
podman pull postgrest/postgrest:v9.0.0.20220211 

podman run --pod=PostgREST \
  --name=postgresql \
  -v /home/ro/Documents/code/Databases/postgresql:/var/lib/postgresql/data \
  -e TZ=America/Cancun \
  -e PGTZ=America/Cancun \
  -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD \
  -e POSTGRES_USER=$POSTGRES_USER \
  -e POSTGRES_DB=$POSTGRES_DB \
  -p 5432:5432 \
  -d postgres


podman run --pod=PostgREST \
  -e PGREST_DB_URI=$PGREST_DB_URI \
  --name postgrest \
  -d postgrest/postgrest

podman generate systemd postgresql -n > postgresql.service
mv postgresql.service ~/.config/systemd/user
systemctl --user daemon-reload
systemctl --user status postgresql
systemctl --user enable --now postgresql
systemctl --user status postgresql
loginctl enable-linger $USER


podman exec -it postgresql bash
# una vez adentro
psql -U posadmin
```