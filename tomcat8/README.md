# Apache Tomcat 8

A service plan for Apache Tomcat 8 web server. 

## Maintainers

The Habitat Maintainers (humans@habitat.sh)

## Type of Package

Service

## Usage

To use this plan add it to your `pkg_deps`. It is recommended that during the build phase you copy or replace the config, init and run hooks. Because the majority of users will use this service with an app that they are creating that may depend on a specific version of java the plan doesn't specify a version. Therefore you will need to also add the `core/jre` version 7 or 8, or the `core/jdk` version 7 or 8 to your apps `pkg_deps`.

```
pkg_deps=(
  core/tomcat8 core/jre8
)
```

Or you can start the service with
```
$ hab pkg install core/jre8
$ hab start core/tomcat8
```

## Exports

This packages exports a `server.port`

## Topologies

### Standalone

To run a standalone Apache Tomcat 8 instance simply run
```
hab start core/tomcat8
```

## Update Strategies

For more information on update strategies, see [this documentation](https://www.habitat.sh/docs/using-habitat/#update-strategy)

If you are running a standalone Tomcat 8 instance and you want to use an update strategy, you should us either "none" (which is the default update strategy) or "at-once"

## Scaling

## Monitoring

## Notes
