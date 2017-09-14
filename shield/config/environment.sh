#!/bin/bash
{{ #with bind.database.first }}
PGPORT="{{cfg.port}}"
PGHOST="{{sys.ip}}"
PG_SUPERUSER="{{cfg.superuser_name}}"
PG_SUPERUSER_PASSWORD="{{cfg.superuser_password}}"
PG_SUPERUSER_URI="postgres://{{cfg.superuser_name}}:{{cfg.superuser_password}}@{{sys.ip}}:{{cfg.port}}/postgres"
{{ /with }}
