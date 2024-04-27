# postgresapi

Instrucciones para correr PostgreSQL y PostgREST en debian usanod podman.

How to host PostgreSQL and PostgREST using podman in debian.

## docs official
https://postgrest.org/en/v12/index.html


``` bash

# create pod
podman pod create --name PostgREST -p $POSTGRES_PORT:$POSTGRES_PORT -p $PGRST_SERVER_PORT:$PGRST_SERVER_PORT

# pull images
podman pull postgres
podman pull postgrest/postgrest

# run PostgreSQL container
podman run --pod=PostgREST \
  --name=postgresql \
  -v $POSTGRES_CONTAINER_DATA_DIR:/var/lib/postgresql/data \
  -e TZ=America/Cancun \
  -e PGTZ=America/Cancun \
  -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD \
  -e POSTGRES_USER=$POSTGRES_USER \
  -e POSTGRES_DB=$POSTGRES_DB \
  -d postgres


# run PostgREST container
podman run --pod=PostgREST \
  -e PGRST_DB_URI=$PGRST_DB_URI \
  -e PGRST_DB_SCHEMAS=$PGRST_DB_SCHEMAS \
  -e PGRST_DB_ANON_ROLE=$PGRST_DB_ANON_ROLE \
  -e PGRST_SERVER_PORT=$PGRST_SERVER_PORT \
  -e PGRST_JWT_SECRET=$PGRST_JWT_SECRET \
  --name postgrest \
  -d postgrest/postgrest

# start both
podman start postgresql & podman start postgrest

# Systemd / optional
podman generate systemd postgresql -n > postgresql.service
mv postgresql.service ~/.config/systemd/user
systemctl --user daemon-reload
systemctl --user status postgresql
systemctl --user enable --now postgresql
systemctl --user status postgresql
loginctl enable-linger $USER

# how to check logs
podman logs postgrest
podman logs postgresql

# how to open bash
podman exec -it postgresql bash

# inside container bash / connect to psql 
psql -U $POSTGRES_USER -d $POSTGRES_DB
```