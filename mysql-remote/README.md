# mysql-remote

A dummy service that can be configured with an arbitrary MySQL connection to health check and provide in place of a mysql bind

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Usage

Configuration options are identical to those of `core/mysql`, but with the addition of `host`:

```yaml
version: '2'

services:
  db:
    image: core/mysql-remote
    environment:
      HAB_MYSQL_REMOTE: |
        app_username = "myuser"
        app_password = "mypassword"
        host = "mysql.example.org"

  app:
    image: myorigin/myapp
    depends_on:
      - db
    command: --peer db --bind database:mysql-remote.default
```

Consuming service need one change made to be able to accept both `mysql` and `mysql-remote` in the same slot.

Where a config template for a consumer service might have look like this originally:

```hbs
{{~#eachAlive bind.database.members as |member|~}}
{{~#if @first}}
database
  host: {{ member.sys.ip }}
  port: {{ member.cfg.port }}
  username: {{ member.cfg.username }}
  password: {{ member.cfg.password }}
  database: {{ ../cfg.database.name }}
{{~/if~}}
{{~/eachAlive}}
```

It should now use `member.cfg.host` in place of `member.sys.ip` if and only if it is available. This allows use of an explicitly-configured `host` while falling back to the peer IP determined by habitat for the bound service:

```hbs
{{~#eachAlive bind.database.members as |member|~}}
{{~#if @first}}
database
  host: {{#if member.cfg.host}}{{ member.cfg.host }}{{else}}{{ member.sys.ip }}{{/if}}
  port: {{ member.cfg.port }}
  username: {{ member.cfg.username }}
  password: {{ member.cfg.password }}
  database: {{ ../cfg.database.name }}
{{~/if~}}
{{~/eachAlive}}
```

## Future considerations

* socat or haproxy might be used to mirror the configured host:port to the local port so that `core/mysql-remote` could truly be a drop-in replacement for `core/mysql`
  * modifying consumer services' config to use `host` would become an optional optimization
  * relaying might be desirable for network security policies
  * opening the relay or just sleeping like before could be controlled by a config option
