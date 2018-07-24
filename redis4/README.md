# Redis4

Redis is an open source (BSD licensed), in-memory data structure store, used as a database, cache and message broker.

## Maintainers

* The Habitat Maintainers <humans@habitat.sh>

## Type of Package

Service package

## Usage

Redis first requires configuration to setup the credentials for protected mode. No defaults are assumed for users of the package.

Example service install / load and setup:

```
hab pkg install core/redis4

echo '
requirepass="password"
' | hab config apply redis4.default $(date +%s)

hab svc load core/redis4
```

## Bindings

Redis provides the bind `port` for other services to bind to.

```
hab svc load my/service --bind redis:redis4.default
```

## Topologies

The default configuration does not enable clustering. This should be addresed in future Habitat plan releases.

For the moment, a `standalone` topology is possible with the default configuration.

## Update Strategies

An `at-once` strategy would suffice for the standalone installation. If you are running in cluster mode, it is recommended that you employ the `rolling` strategy.
