# Caddy

Fast, cross-platform HTTP/2 web server with automatic HTTPS

## Maintainers

* The Habitat Maintainers <humans@habitat.sh>

## Type of Package

Service package

## Usage

This package can be used as binary or service package.

Usage as a binary package is simply running the command after installation:

```
hab pkg install --binlink core/caddy
caddy
```

As a service package, you can load the service and use the bundled default configuration:

```
hab pkg install core/caddy
hab svc load core/caddy
```

Or you can wrap this with a configuration plan, by adding `core/caddy` as a runtime dependency of your plan:

```
...
pkg_deps=(core/caddy)
...
```

## Bindings

Caddy exposes a `port` variable containing the HTTP listening port. This can be referenced in service bindings.

```
hab svc load my/service --bind caddy.default
```

## Topologies

This package currently only supports the standalone topology.

## Update Strategies

The recommended update strategy is `at-once`.

## Notes

The default configuration is extremely simple and may likely not meet your specific needs.

We recommend that for customization, you wrap this with a configuration plan as mentioned in the **Usage** section above.

Additionally, the default configuration uses port `8080` to allow running without root privileges. If you want to run on a sub `1024` port number, you will need to compose a wrapper plan and change the `pkg_svc_user`.
