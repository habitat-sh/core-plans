# Plan Configuration Complexity

## Summary
[summary]: #summary

When packaging software with Habitat, we need to ensure we have an agreed level of complexity with regards to the configuration that is shipped. This RFC proposes a standard by which plans can be developed, and kept simple and functional.

## Motivation
[motivation]: #motivation

As the [core-plans][core-plans] repository continues to evolve and grow, more users are coming with new and useful use cases for the software that is packaged with Habitat. In order to ensure we maintain the core plans as simple, functional, testable and model examples of software packaging, we must ensure complexity is kept to a minimum. This will encourage simpler configuration in [core-plans][core-plans] plans, and encourage users to use the configuration plan pattern to extend configuration where necessary.

## Guide-level explanation
[guide-level-explanation]: #guide-level-explanation

A habitat [core-plan] is a plan that is supported and published by core-contributors of the Habitat community. These are often relied upon by other plans, and as part of the Habitat build process itself.

A core-plan's primary responsibility is to ensure the binaries and associated files responsible for running the commands or services are correctly built, packaged and released. In addition, for service packages, a minimal configuration representing the minimal/default service configuration is shipped to ensure that services can start in a simple state. This simple/minimal state is representative of the default configuration and minimal configuration required to get the service running.

While more complicated and extensive configuration may be possible, a concious effort must be maintained in core-plans, to ensure that the configuration is kept simple and minimal. The implementing user has the opportunity to use "configuration plans" to extend the service and offer more customised configuration as necessary for their service.

For example, MongoDB is a complicated piece of software with a large range of configuration options available to it. It is not the responsibility of Habitat to ensure that all configuration options are represented in the default configuration, but to ensure that MongoDB can run in a default state, and allow users to further configure the service. The following is an exmaple of the MongoDB configuration file for core-plans, designed specifically to be minimal, and simple:

```
# File: core-plans/mongodb/config/mongod.conf
#
# for documentation of all options, see:
#   http://docs.mongodb.org/manual/reference/configuration-options/

# Where and how to store data.
storage:
  dbPath: {{pkg.svc_data_path}}/db
  journal:
    enabled: {{cfg.mongod.storage.journal.enabled}}

# where to write logging data.
systemLog:
  verbosity: {{cfg.mongod.system_log.verbosity}}
  quiet: {{cfg.mongod.system_log.quiet}}
  destination: file
  logAppend: true
  path: {{pkg.svc_var_path}}/mongod.log

# network interfaces
net:
  port: {{cfg.mongod.net.port}}
  bindIp: {{cfg.mongod.net.bind_ip}}

security:
  authorization: {{cfg.mongod.security.authorization}}
```

The options presented use handlebars helpers/variable injection where necessary to ensure the service starts, and some static values for simple/basic configuration defaults.

A user wanting to implement this service and further customise the configuration must employ a "configuration plan" to wrap the MongoDB service package, and provide their own configuration:

```
# File: my-mongo/plan.sh
pkg_name=my-mongo
pkg_origin=my-origin
pkg_version=3.6.4
pkg_maintainer="Graham Weldon <graham@grahamweldon.com>"
pkg_description="High-performance, schema-free, document-oriented database"
pkg_license=('AGPL-3.0')
pkg_deps=(
  core/mongodb
)
pkg_svc_run="mongod --config ${pkg_svc_config_path}/mongod.conf"
pkg_exports=(
  [port]=mongod.net.port
)
pkg_exposes=(port)
```

This plan, which wraps the core-plans MongoDB plan, would also add its own configuration:

```
# File: my-mongo/config/mongod.conf
storage:
  dbPath: {{pkg.svc_data_path}}/db
  journal:
    enabled: {{cfg.mongod.storage.journal.enabled}}
systemLog:
  verbosity: {{cfg.mongos.system_log.verbosity}}
  quiet: {{cfg.mongos.system_log.quiet}}
  traceAllExceptions: {{cfg.mongos.system_log.trace_all_exceptions}}
  syslogFacility: {{cfg.mongos.system_log.syslog_facility}}
  logAppend: {{cfg.mongos.system_log.log_append}}
  logRotate: {{cfg.mongos.system_log.log_rotate}}
  timeStampFormat: {{cfg.mongos.system_log.time_stamp_format}}
  path: {{pkg.svc_var_path}}/mongos.log
  destination: {{cfg.mongos.system_log.destination}}
net:
  port: {{cfg.mongod.net.port}}
  bindIp: {{cfg.mongod.net.bind_ip}}
security:
  authorization: {{cfg.mongod.security.authorization}}
```

In this case, more options and configurability are provided to the `systemLog` section of the configuration, and can be modified at the users discretion.

Some good ways to consider how appropriate a configuration is for contribution to core-plans, contributors can reference a couple of sources:

* What do other distributions ship as a default configuration for this package? Check Ubuntu, Debian, CentOS, Arch, and any other Linux distributions for examples.
* What is the minimal configuration required to get the service running?

## Reference-level explanation
[reference-level-explanation]: #reference-level-explanation

See the Guide-level explanation

## Drawbacks
[drawbacks]: #drawbacks

In the case of existing plans in [core-plans][core-plans], some users may already be using packages that include more complicated/extensive configuration options. Thus any changes to reduce and simplify configuration would impact existing users negatively. They would be required to create a configuration plan to implement any configuration options that were removed.

## Rationale and alternatives
[alternatives]: #alternatives

This approach keeps core plans simple. It also encourages the use of the configuration plan approach, which pushes core plans to dependencies of deployed plans, rather than being run directly.

It also more closely matches what happens in existing package managers in the wild, whereby a minimal configuration is shipped which can be then customised further by the user.

If [core-plans][core-plans] is not formalised to reduce configuration complexity, the ongoing testing requirements for releases becomes much greater, and the management of pull requests also increases, which will impact the velocity at which we can manage the plan releases.

## Unresolved questions
[unresolved]: #unresolved-questions

- How do we inform users of a change that reduces configuration complexity through removing configuration options?

[core-plans]: https://github.com/habitat-sh/core-plans
