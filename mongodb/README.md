# MongoDB

MongoDB stores data in flexible, JSON-like documents, meaning fields can vary from document to document and data structure can be changed over time.

## Maintainers

* The Habitat Maintainers <humans@habitat.sh>

## Type of Package

Service package

## Usage

Start the service:

```
hab pkg install core/mongodb
hab svc load core/mongodb
```

## Bindings

MongoDB exposes `port` for other services to bind to, for connecting to MongoDB.

## Topologies

While the core-plans configuration is currently only supporting standalone, this plan can be wrapped with a configuration plan to support more complex deployments. See the section below on "configuration plans".

## Update Strategies

As a single node deployment in standalone, the recommended update strategy is `at-once`.

## Configuration plans

MongoDB is a complex service, and can be configured in a variety of setups with variations to the configuration files.

Using the "configuration plan" pattern, you can wrap the service from core-plans, and provide your own configuration.

```
pkg_name=my-mongodb
pkg_origin=my-origin
pkg_version=3.6.4
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('AGPL-3.0')
pkg_deps=(
  core/mongodb
)
pkg_svc_run="mongod --config ${pkg_svc_config_path}/mongod.conf"
pkg_exports=(
  [port]=mongod.net.port
)
pkg_exposes=(port)
```

With this in place for your own origin and plan, add in your own configuration file in `config/mongod.conf`.

The config file should be fully standalone, as the `core/mongodb` config file will not be used at all.
