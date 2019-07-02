# opendistro-for-elasticsearch

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Service package

## Usage

Install the package, and load the service:

```bash
hab pkg install core/opendistro-for-elasticsearch
hab svc load core/opendistro-for-elasticsearch
```

## Bindings

Services consuming opendistro-for-elasticsearch can bind via:

```
hab svc load origin/package --bind elasticsearch:opendistro-for-elasticserach.default
```

Elasticsearch's contract presents the following ports to bind to:

- `http-port`
- `transport-port`

## Topologies

Currently this plan supports standalone topology.

## Update Strategies

No update strategy or at-once update strategy works fine in a single-node installation.

### Configuration Updates
