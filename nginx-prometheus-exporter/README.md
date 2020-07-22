# nginx-prometheus-exporter

NGINX Prometheus exporter makes it possible to monitor NGINX or NGINX Plus using Prometheus.

## Maintainers

* The Habitat Maintainers <humans@habitat.sh>

## Type of Package

Service package

## Usage

This package is designed to be run in conjunction with an Nginx server that is using the `stub_status` output.

You can either inject configuration to specify the Nginx endpoint to collect data from (by default, `http://localhost:8080/stub_status`), or bind to an Nginx server that has exported the `stub_status_port` and `stub_status_path` data.

```
hab svc load my/nginx-with-stub-status

hab svc load core/nginx-prometheus-exporter \
  --bind nginx:nginx-with-stub-status.default
```

## Topologies

### Standalone

This is a standalone server, and is run once per Nginx instance you have running. Ideally run this standalone, on each instance.
