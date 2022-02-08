# haproxy

HAProxy is a free, very fast and reliable solution offering high availability, load balancing, and proxying for TCP and HTTP-based applications. It is particularly suited for very high traffic web sites and powers quite a number of the world's most visited ones.

## Maintainers

The Habitat Maintainers humans@habitat.sh

## Type of Package

This is a service package that will be run by the Habitat supervisor.

## Usage

You can start the service with:

```
$ hab start core/haproxy17
```

And bind another Habitat service to it - see "Binding" below for more details.

## Bindings

Consuming services can bind to HAProxy via:

```
hab svc load core/haproxy17 --bind port:haproxy.default
```

## Topologies

This plan currently only supports the standalone topology.

### Standalone

To run a standalone haproxy instance, run

```
hab sup run --topology standalone
hab svc load core/haproxy17
```

The standalone topology is used by default by the habitat supervisor if none is specified.
For more details on the standalone topology, see [the Habitat docs on standalone](https://www.habitat.sh/docs/using-habitat/#standalone).

### Leader-Follower

This plan does not make use of the leader/follower topology.

Check out [the Habitat docs on Leader-Follower](https://www.habitat.sh/docs/using-habitat/#leader-follower-topology) for more details on what the leader-follower topology is and what it does.

## Update Strategies

The authors do not provide any recommendations for how to use update strategies with this package.

Check out [the update strategy documentation](https://www.habitat.sh/docs/using-habitat/#update-strategy) for information on the strategies Habitat supports.

### Configuration Updates

Check out the [configuration update](https://www.habitat.sh/docs/using-habitat/#configuration-updates) documentation for more information on what configuration updates are and how they are executed.

Take a look at the [default.toml](default.toml) for this package to see the configuration settings you can override.

## Scaling

This package does not currently support high availability on its own.

## Monitoring

This service can be monitored by making TCP connections to the configured port (default is 80)
