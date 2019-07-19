# Multichain

Open platform for building blockchains.

## Maintainers

* The Habitat Maintainers <humans@habitat.sh>

## Type of Package

Service Package

Although this ships as a service package, it really can only be useful and secure when wrapped with a Configuration Plan. Do not deploy this for production use without customization.

## Usage

```
hab pkg install core/multichain
hab svc load core/multuchain
```

Check command line / log output for credentials and connection information.

## Bindings

* `port` is exposed for other multichaind servers to connect to
* `rpcport` is exposed for RPC / CLI communication and configuration

## Topologies

This should be deployed in a standalone topology.

## Update Strategies

Do not deploy Multichaind with an update strategy. Currently the requirements of the service and package paths don't allow auto-updating.
