# Apache Tomcat 8

A plan for Apache Tomcat 8 web server. 

## Maintainers

The Habitat Maintainers (humans@habitat.sh)

## Type of Package

Binary

## Usage

To use this plan add it to your `pkg_deps`. It is recommended that during the build phase you copy the default.toml, config, init and run hooks from the example folder so that you can start tomcat.

```
pkg_deps=(
  core/tomcat8 core/jre8
)
```

## Exports

This packages exports a `server.port` in the plan.
