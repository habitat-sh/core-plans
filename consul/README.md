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
The agent is the main binary run for Consul and can be run in one of two modes:
Server or Client. Please see the [Consul agent documentation](3) for more information.

#### Server
As a [server](3), Consul provides storage of the state of the system as well as Key
Value.

#### Client
As a client, Consul client mode provides the ability for services to register
with their local Consul client agents. These clients then gossip, via Raft,
to the other nodes to let the rest of the system know that the service is
available. Additionally, the client provides health checks of the registered
services.

## Update Strategy

Recommended update strategy for Consul is `rolling`.

## ACLs

ACLs have changed as of Consul 1.4. This plan currently does _not_ enable you
to use ACLs.

[1]: https://consul.io
[2]: https://www.consul.io/docs/guides/bootstrapping.html
[3]: https://www.consul.io/docs/agent/basics.html
