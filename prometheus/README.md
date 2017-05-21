Habitat plan for Prometheus
======

Build a named release branch of prometheus from git, 
leveraging the promu compile utility to generate binaries
with the version number baked in.

Config
---

If the prometheus service is launched with a binding of `targets` then the `from_hab_ring` job will be populated by the metric exporters in that bound service. (e.g. node_exporter)

Jobs to scrape /federation targets are enabled if we are in a leader/follower topology. 

Otherwise you can modify the included templated config as you see fit. 

Topologies
---

Standalone - runs prometheus with a templated config

Leader - self-federating. with only the leader performing checks. The follower(s) are responsible for longer term persistent data storage and/or serving queries.  

Exports
---

This prometheus package exports the http endpoint as `prom_ds_http` with the expectation that you might bind that to `core/grafana` with `--bind prom:<this_service_group>`


multi node example
---
The below commands would give you a 3 node prometheus cluster with the two followers copying all data series from the leader.

```shell
docker run -ti --rm -P --name prom0 fastrobot/prometheus --topology leader --group test
docker run -ti --rm -P --name prom1 --link prom0:peer_node fastrobot/prometheus --topology leader --group test --peer peer_node
docker run -ti --rm -P --name prom2 --link prom0:peer_node fastrobot/prometheus --topology leader --group test --peer peer_node
```

Discover targets using the hab ring
---

The below command would start a single prometheus instance and add any node_exporter metric source that appears in the service group ```node_exporter.demo```
```
docker run -ti --rm -P --name prom0 fastrobot/prometheus --topology standalone --peer 172.17.0.3 --group demo --bind targets:node_exporter.demo

```