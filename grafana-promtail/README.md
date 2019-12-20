# grafana-promtail

[Promtail](https://github.com/grafana/loki/tree/master/docs/clients/promtail) is an agent which ships the contents of local logs to a private Loki instance or Grafana Cloud. It is usually deployed to every machine that has applications needed to be monitored.

## Maintainers

The Habitat Maintainers humans@habitat.sh

## Type of Package

Service

## Usage

```bash
hab svc load core/grafana-promtail --bind loki:<loki_svc_group>
```

This will load up a promtail service on http 9080 and a random port for grpc. A default scrape config is provided that will scrape the hab-sup logs from the default ring.

This service is intended to work in conjunction with [loki](../loki/README.md) so that it can ship the logs.

## Bindings

### `--bind loki:<loki_svc_group>`

This is a required binding as promtail needs to know where to ship the logs.
