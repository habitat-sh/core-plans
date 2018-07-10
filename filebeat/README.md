# Habitat package: filebeat

Lightweight shipper for logfiles.

## Maintainers

The Habitat Maintainers (humans@habitat.sh).

## Type of package

Service package.

## Usage

```
hab svc load core/filebeat
```

Filebeat will run with the default configuration, which checks for and forwards logs from `/var/log/*.log`. This most likely doesn't match your needs for filebeat. Customize your configuration by following the instructions under configuration plans, below.

## Bindings

This plan does not export any configuration to bind to.

It does, however, optionally bind to a number of other services:

* Kibana
* Elasticsearch

Refer to `filebeat.yml` for examples of where these are used.

If no bindings are specified, the default configuration is to forward to elasticsearch on the loopback device, on the default port: `127.0.0.1:9200`

## Configuration Plans

This plan is most likely only useful when wrapped with a configuration plan.

A configuration plan is a simple plan that declares a dependency on another plan, and adds configuration / settings as necessary to customize the service.

A configuration plan that uses this could look like:

```
pkg_name=myfilebeat
pkg_origin=work
pkg_version="6.3.1"
pkg_deps=(core/filebeat)
```

Then simply write your own configuration for `filebeat.yml` as required.

## Topology

Recommended topology is `standalone`.

## Update strategies

Recommended update strategy is `at-once`.
