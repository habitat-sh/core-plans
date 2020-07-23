# grafana-loki

[Loki](https://grafana.com/oss/loki/) is a horizontally-scalable, highly-available, multi-tenant log aggregation system inspired by Prometheus.

## Maintainers

The Habitat Maintainers humans@habitat.sh

## Type of Package

Service

## Usage

```bash
hab svc load core/grafana-loki
```

This will load up the grafana service on `loki_ds_http = 3100` and `loki_ds_grpc = 9095`.

This service is intended to work in conjunction with [grafana](../grafana/README.md) as the frontend.  One of several types of log clients then deliver logs to the service.
