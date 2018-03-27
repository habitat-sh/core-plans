# Prometheus

Build a named release branch of prometheus from git, leveraging the promu compile utility to generate binaries with the version number baked in.

## Maintainers

The Habitat Maintainers humans@habitat.sh

## Type of Package

Service

## Usage

Jobs to scrape /federation targets are enabled if we are in a leader/follower topology.

Otherwise you can modify the included templated config as you see fit.

## Bindings

This prometheus package exports the http endpoint as `prom_ds_http` with the expectation that you might bind that to `core/grafana` with `--bind prom:<this_service_group>`

The below command would start a single prometheus instance and add any node_exporter metric source that appears in the service group ```node_exporter.demo```
```
docker run -ti --rm -P --name prom0 fastrobot/prometheus --topology standalone --peer 172.17.0.3 --group demo --bind targets:node_exporter.demo
```

## Topologies

### Standalone

Standalone - runs prometheus with a templated config

### Leader-Follower

Leader - self-federating. with only the leader performing checks. The follower(s) are responsible for longer term persistent data storage and/or serving queries.

The below commands would give you a 3 node prometheus cluster with the two followers copying all data series from the leader.

```shell
docker run -ti --rm -P --name prom0 fastrobot/prometheus --topology leader --group test
docker run -ti --rm -P --name prom1 --link prom0:peer_node fastrobot/prometheus --topology leader --group test --peer peer_node
docker run -ti --rm -P --name prom2 --link prom0:peer_node fastrobot/prometheus --topology leader --group test --peer peer_node
```

## Update Strategies

If you are running a standalone Prometheus instance and want to use an update strategy, you should use either "none" (which is the default update strategy) or "all-at-once"

If you are running a Prometheus cluster, you will likely want to use the Rolling strategy.

### Configuration Updates

For details on what is configurable, check out this plan's [Default.toml](./Default.toml)

## Scaling

This plan supports running in a leader/follower cluster, it has not yet been tested in a highly available configuration.

## Monitoring

Prometheus, being a monitoring solution, can monitor itself.  For inforation about how to se this up, check out [the official Prometheus docs](https://prometheus.io/docs/prometheus/latest/getting_started/#configuring-prometheus-to-monitor-itself).