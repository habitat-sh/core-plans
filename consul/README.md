# Habitat package: consul

## Description

[Consul](1) is Service Discovery and Configuration Made Easy.

This plan provides the static binary for execution.

## Usage

### For development:
```
hab svc load core/consul
```

### For a cluster:
On each node,
```
hab svc load core/consul --topology standalone --strategy rolling --group leaders
```
additionally, set a config TOML with:
```
appmode = "server"
local_only = false
[server]
mode = true
```
and any other tweaks you'd like to make. If changing the datacenter, you'll have to delete all data from `/hab/svc/consul` if the service has already been deployed, otherwise set the configuation prior to starting the service and the datacenter setting should work as expected.

### For a client
On the client node,
```
hab svc load core/consul --topology standalone --strategy rolling --group client --bind leaders:consul.habitat
```
and set a config TOML with:
```
appmode = "client"
local_only = true
[server]
mode = false
```
which will cause the client to work as expected.


## Topology

Consul can be deployed as a single node for testing, with `standalone` topology, or in a multi-node setup also as `standalone`. The nodes share the same configuration, and can utilize service member IP addresses for [consul join commands](2) or using the [start_join configuration](2) options.

## Update Strategy

Recommended update strategy for Consul is `rolling`.

[1]: https://consul.io
[2]: https://www.consul.io/docs/guides/bootstrapping.html
