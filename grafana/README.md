# Grafana

This Habitat plan installs stock [grafana](http://grafana.com) and has the following optional binds:

- a [prometheus](../prometheus/README.md) datasource along with some sample prometheus dashboards
- a [loki](../grafana-loki/README.md) datasource

## Maintainers

The Habitat Maintainers humans@habitat.sh

## Type of Package

Service

## Usage

```bash
hab svc load core/grafana
```

This will load up the grafana service on port 80.

## Bindings

### `--bind prom:<prometheus_svc_group>`

A post-run hook will install the prometheus datasource and copy stock prometheus and node_exporter dashboards.

### `--bind loki:<loki_svc_group>`

A post-run hook will install the loki datasource.  No stock datasources avaliable.
