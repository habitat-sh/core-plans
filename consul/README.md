# Habitat package: consul

## Description

[Consul](1) is Service Discovery and Configuration Made Easy.

This plan provides the static binary for execution.

## Usage

```
hab svc load core/consul
```

## Topology

Consul can be deployed as a single node for testing, with `standalone` topology, or in a multi-node setup also as `standalone`. The nodes share the same configuration, and can utilize service member IP addresses for [consul join commands](2) or using the [start_join configuration](2) options.

### Agent

#### Server

#### Client

## Update Strategy

Recommended update strategy for Consul is `rolling`.

## ACLs

ACLs have changed as of Consul 1.4. This plan currently does _not_ enable you
to use ACLs. We will add this feature soon!

[1]: https://consul.io
[2]: https://www.consul.io/docs/guides/bootstrapping.html
