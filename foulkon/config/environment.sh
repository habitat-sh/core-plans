#!/bin/bash

{{#if bind.database}}
{{~#eachAlive bind.database.members as |member|}}
PGPORT="{{member.cfg.port}}"
PGHOST="{{member.sys.ip}}"
PG_SUPERUSER="{{member.cfg.superuser_name}}"
PG_SUPERUSER_PASSWORD="{{member.cfg.superuser_password}}"
PG_SUPERUSER_URI="postgres://{{member.cfg.superuser_name}}:{{member.cfg.superuser_password}}@{{member.sys.ip}}:{{member.cfg.port}}/postgres"
{{~/eachAlive}}
{{else}}
{{#with cfg}}
PGPORT="{{storage.port}}"
PGHOST="{{storage.host}}"
PG_SUPERUSER="{{storage.superuser_name}}"
PG_SUPERUSER_PASSWORD="{{storage.superuser_password}}"
PG_SUPERUSER_URI="postgres://{{storage.superuser_name}}:{{storage.superuser_password}}@{{storage.host}}:{{storage.port}}/postgres"
{{/with}}
{{/if}}
