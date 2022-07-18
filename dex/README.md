[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.dex?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=206&branchName=master)

# dex

Dex is an identity service that uses OpenID Connect to drive authentication for other apps.  Dex acts as a portal to other identity providers through "connectors."   See [documentation](https://github.com/dexidp/dex)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Service package

### Use as Dependency

Service packages can be set as runtime (as well as build time) dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/dex as a runtime dependency, you can add the following to your plan file.

> pkg_deps=(core/dex)

If for some reason, this package is only needed as a build time dependency then do not include it in pkg_deps, but only in pkg_build_deps:

> pkg_build_deps=(core/dex)

### Using dex as a habitat service

Simple usage from a hab studio:

```bash
$ # build and install dex
$ build .
$ source ./results/last_build.env
$ hab pkg install ./results/$pkg_artifact
$
$ # export and run as a docker container
$ hab pkg install core/docker core/hab-pkg-export-docker
$ hab pkg export docker ./results/$pkg_artifact
$ hab pkg exec core/docker docker run --name core_dex -p 9000:9000 --rm -de HAB_LICENSE=accept core/dex
```

For more information see:

* [Running Chef Habitat Packages](https://www.habitat.sh/docs/using-habitat/using-packages/) for more information.
* [Service Groups](https://www.habitat.sh/docs/using-habitat/service-groups/)
* [Topologies](https://www.habitat.sh/docs/using-habitat/topologies/)
* [Update Strategy](https://www.habitat.sh/docs/using-habitat/using-updates/)
* [Binds and Exports](https://www.habitat.sh/docs/developing-packages/#runtime-binds-and-exports)

## Further development of the dex plan

The hab studio provides an excellent way to further develop and or troubleshoot the dex hab service.  Since dex provides an http endpoint on port 5556, then enter a hab studio with the following command.

``HAB_DOCKER_OPTS="-p 5556:5556" hab studio enter -D``

Once in the studio, then build and load the service:

```bash
build .
source ./results/last_build.env
hab pkg install ./results/$pkg_artifact
hab svc load $pkg_ident
```

Verify the http endpoint, e.g., open a browser at http://localhost:5556/

For example:

```bash
# build dex
[21][default:/src/dex:0]# build .
building artifact
...
...
'/hab/cache/artifacts/core-dex-2.24.0-20200826103442-x86_64-linux.hart' -> '/src/dex/results/core-dex-2.24.0-20200826103442-x86_64-linux.hart'
   dex: hab-plan-build cleanup
   dex: 
   dex: Source Path: /hab/cache/src/dex-2.24.0
   dex: Installed Path: /hab/pkgs/core/dex/2.24.0/20200826103442
   dex: Artifact: /src/dex/results/core-dex-2.24.0-20200826103442-x86_64-linux.hart
   dex: Build Report: /src/dex/results/last_build.env
   dex: SHA256 Checksum: 86d51165eadc82d9bd29a59dad5f2289830f99b78eb8b4b5bc0754977170c3fd
   dex: Blake2b Checksum: 6cbd551048d0e73aa21d7636b2d697740fa14da449242b6a1c5e7bf291afed0b
   dex: 
   dex: I love it when a plan.sh comes together.
   dex: 
   dex: Build time: 0m33s

# install dex
[22][default:/src/dex:0]# source ./results/last_build.env
[23][default:/src/dex:0]# hab pkg install ./results/$pkg_artifact

# load as a habitat service
[25][default:/src/dex:0]# hab svc load $pkg_ident
The core/dex/2.24.0/20200826103442 service was successfully loaded

# verify that the service is running
[26][default:/src/dex:0]# hab svc status
package                         type        desired  state  elapsed (s)  pid     group
core/dex/2.24.0/20200826103442  standalone  up       down   2            <none>  dex.default
```
