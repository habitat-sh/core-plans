[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.concourse?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=201&branchName=master)

# concourse

Concourse is a pipeline-based continuous thing-doer.  This habitat plan _only_ provides users access to the standalone binaries.  As a result, anyone using this habitat package will need to write their own plan that depends on this package and provide their own runtime management.  See the [Additional Steps](#additional-steps) section for an example setup.

Refer also to the [documentation](https://concourse-ci.org/docs.html)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/concourse as a dependency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/concourse)

##### Runtime dependency

> pkg_deps=(core/concourse)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/concourse --binlink``

will add the following binary to the PATH:

* /bin/concourse

For example:

```bash
$ hab pkg install core/concourse --binlink
» Installing core/concourse
☁ Determining latest version of core/concourse in the 'stable' channel
→ Found newer installed version (core/concourse/4.2.2/20200818102606) than remote version (core/concourse/4.2.2/20200404015818)
→ Using core/concourse/4.2.2/20200818102606
★ Install of core/concourse/4.2.2/20200818102606 complete with 0 new packages installed.
» Binlinking concourse from core/concourse/4.2.2/20200818102606 into /bin
★ Binlinked concourse from core/concourse/4.2.2/20200818102606 to /bin/concourse
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/concourse --help`` or ``concourse --help``

```bash
$ concourse --help
Usage:
  concourse [OPTIONS] <command>

Application Options:
  -v, --version  Print the version of Concourse and exit [$CONCOURSE_VERSION]

Help Options:
  -h, --help     Show this help message

Available commands:
  land-worker    Safely drain a worker's assignments for temporary downtime.
  migrate
  quickstart     Run both 'web' and 'worker' together, auto-wired. Not recommended for production.
  retire-worker  Safely remove a worker from the cluster permanently.
  web            Run the web UI and build scheduler.
  worker         Run and register a worker.
```

#### Additional Steps

Concourse is a complex piece of software with multiple ways in which it can be configured to run. As such we provide this package to enable you to wrap and automate your preferred deployment style.

Below we have provided an example configuration for deploying Concourse.

**concourse-web/plan.sh**

```bash
pkg_name=concourse-web
pkg_origin=eeyun
pkg_version="0.1.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_deps=(core/concourse core/postgresql)
pkg_exports=(
   [web_port]=ports.web
)
pkg_exposes=(web_port)
pkg_binds_optional=(
   [database]="web_port host"
)
pkg_description="Some description."
pkg_upstream_url="https://concourse.ci/"

do_build(){
  return 0
}

do_install(){
  return 0
}
```

**concourse-web/default.toml**

```toml
[concourse]
username = "concourse"
password = "changeme"

[ports]
web = "8080"

[postgres]
host_ip = "localhost"
username = "concourse"
password = "changeme"
dbname = "concourse"
```

**concourse-web/hooks/run**

```bash
#!/bin/bash -xe
#
exec 2>&1

source "{{pkg.svc_config_path}}/config.sh"

cd {{pkg.svc_path}}

PG_PASS=$CONCOURSE_POSTGRES_PASSWORD
PG_HOST=$CONCOURSE_POSTGRES_HOST

if PGPASSWORD=$PG_PASS psql -lqt -h $PG_HOST -U $CONCOURSE_POSTGRES_USER | cut -d \| -f 1 | grep -qw concourse; then
    echo "first thing it work fine"
else
    PGPASSWORD=$PG_PASS createdb $CONCOURSE_POSTGRES_DATABASE -h $PG_HOST -U $CONCOURSE_POSTGRES_USER
fi

concourse web \
    --session-signing-key {{pkg.svc_files_path}}/session_signing_key \
    --tsa-host-key {{pkg.svc_files_path}}/tsa_host_key \
    --tsa-authorized-keys {{pkg.svc_files_path}}/authorized_worker_keys
```

**concourse-web/config/config.sh**

```bash
#!/bin/bash

export CONCOURSE_BASIC_AUTH_USERNAME="{{cfg.concourse.username}}"
export CONCOURSE_BASIC_AUTH_PASSWORD="{{cfg.concourse.password}}"
export CONCOURSE_EXTERNAL_URL="${CONCOURSE_EXTERNAL_URL}"

{{#if bind.database ~}}
{{#with bind.database.first as |pg| }}
export CONCOURSE_POSTGRES_HOST="{{pg.sys.ip}}"
export CONCOURSE_POSTGRES_USER="{{pg.cfg.superuser_name}}"
export CONCOURSE_POSTGRES_PASSWORD="{{pg.cfg.superuser_password}}"
export CONCOURSE_POSTGRES_DATABASE="{{cfg.postgres.dbname}}"
{{/with}}
{{else ~}}
export CONCOURSE_POSTGRES_HOST="{{cfg.postgres.host_ip}}"
export CONCOURSE_POSTGRES_USER="{{cfg.postgres.username}}"
export CONCOURSE_POSTGRES_PASSWORD="{{cfg.postgres.password}}"
{{/if ~}}

export CONCOURSE_POSTGRES_DATABASE="{{cfg.postgres.dbname}}"
```

The above configuration when bound to a postgres instance with `--bind database:postgresql.default` gives you a concourse web server **WITH NO WORKER NODES**. It does not give you a working cluster and should only be used as an example for one possible shape of deployment. Following this pattern you would want to theoretically create ANOTHER package for concourse-worker that similarly starts a concourse worker and binds to concourse-web.

With this above pattern you'll need to generate and upload the appropriate concourse keys to the appopriate service groups. In the case of the concourse-web example above that means generating and uploading the `session_signing_key`, the `tsa_host_key` and the `authorized_worker_keys`.
