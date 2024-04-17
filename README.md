# postgresapi

https://postgrest.org/en/v12/index.html


``` bash
podman pod create --name PostgREST -p $POSTGRES_PORT:$POSTGRES_PORT -p $PGRST_SERVER_PORT:$PGRST_SERVER_PORT
podman pull postgres
podman pull postgrest/postgrest

podman run --pod=PostgREST \
  --name=postgresql \
  -v /home/ro/Documents/code/Databases/postgresql:/var/lib/postgresql/data \
  -e TZ=America/Cancun \
  -e PGTZ=America/Cancun \
  -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD \
  -e POSTGRES_USER=$POSTGRES_USER \
  -e POSTGRES_DB=$POSTGRES_DB \
  -d postgres


podman run --pod=PostgREST \
  -e PGRST_DB_URI=$PGRST_DB_URI \
  -e PGRST_DB_SCHEMAS=api \
  -e PGRST_DB_ANON_ROLE=web_anon \
  -e PGRST_SERVER_PORT=$PGRST_SERVER_PORT \
  --name postgrest \
  -d postgrest/postgrest

podman generate systemd postgresql -n > postgresql.service
mv postgresql.service ~/.config/systemd/user
systemctl --user daemon-reload
systemctl --user status postgresql
systemctl --user enable --now postgresql
systemctl --user status postgresql
loginctl enable-linger $USER

# logs
podman logs postgrest
podman logs postgresql

podman exec -it postgresql bash
# una vez adentro
psql -U $POSTGRES_USER -d $POSTGRES_DB
```