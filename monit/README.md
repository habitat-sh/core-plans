# Monit

This plan packages [monit](https://mmonit.com/monit), a monitoring agent with powers (it can restart processes on failure and so on).

## Maintainers

The Habitat Maintainers: <humans@habitat.sh>

## Type of package

Service package (Intended for wrapping with a configuration plan, see usage notes below).

## Usage

When using monit, you'll want to add your own rules, this cannot be done with this package. You'll need to create your own which would depend on this one. The configuration is provided as a model for you to speed up your package development.

```
hab svc load core/monit
```

## Bindings

This package exports the `port` variable that the httpd server is listening on.

Note that this is only able to be connected to from `localhost` by default. You will want to change these restrictions in you *configuration plan* before attempting to bind to this service.

## Topologies

Monit is designed to be run in `standalone` topology.

## Update strategies

`at-once` is a good update strategy for this, due to the recommended standalone topology.
