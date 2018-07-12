# Elasticsearch

[Elasticsearch][elasticsearch] is an Open Source, Distributed, RESTful Search Engine

## Maintainers

* The Habitat Maintainers <humans@habitat.sh>

## Type of Package

Service package

## Usage

```
hab pkg install core/elasticsearch
hab svc load core/elasticsearch
```

## Bindings

Consume an elasticsearch service like so:

```
hab start <origin>/<app> --bind elasticsearch:elasticsearch.default --peer <es_host>
```

Elasticsearch exposes a `http-port` and `transport-port`. The [transport protocol][transport-protocol] is for inter-node communication in the Elasticsearch cluster.

No user credentials are exposed to the binding application. User credential setup and exposure is beyond the scope of this basic service package.

## Topologies

`standalone` topology is enough for Elasticsearch in a small or single node setup, as it handles its own master/leader election internally.

However, if you want to take advantage of a `rolling` update strategy, the topology should be `leader`.

## Update Strategies

* `at-once` for a single node, or small number of nodes
* `rolling` is more appropriate for production workloads, and requires a `leader` topology.

## Monitoring

Elasticsearch exposes cluster health information via HTTP(s). The [documentation][health-docs] details how to read and parse that data.

Examples of this can be found in the `health_check` [hook][health-hook].

[elasticsearch]: https://www.elastic.co/products/elasticsearch
[transport-protocol]: https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-transport.html
[health-docs]: https://www.elastic.co/guide/en/elasticsearch/reference/current/cluster-health.html
[health-hook]: hooks/health_check
