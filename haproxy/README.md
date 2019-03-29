# haproxy

HAProxy is a free, very fast and reliable solution offering high availability, load balancing, and proxying for TCP and HTTP-based applications. It is particularly suited for very high traffic web sites and powers quite a number of the world's most visited ones.

## Maintainers

The Habitat Maintainers humans@habitat.sh

## Type of Package

This is a service package that will be run by the Habitat supervisor.

## Usage

You can start the service with:

```
$ hab start core/haproxy
```

And bind another Habitat service to it - see "Binding" below for more details.

## Bindings

Consuming services can bind to HAProxy via:

```
hab svc load core/haproxy --bind port:haproxy.default
```

## Topologies

This plan currently only supports the standalone topology.

### Standalone

To run a standalone haproxy instance, run

```
hab sup run --topology standalone
hab svc load core/haproxy
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

# Testing haproxy

Since the haproxy does not run in isolation but must be bound to a backend webserver, the following instructions exercise it in a simple scenario, one haproxy and one backend web server.

**Note**: The following manual steps can be performed in one automated step: [see these instructions](#automate-the-build-and-test)

### Build the haproxy core plan

Ensure that:
* the [core-plan repo](https://github.com/habitat-sh/core-plans) is cloned locally
* a terminal is opened to the root of the repo

For example

```bash
git clone https://github.com/habitat-sh/core-plans.git
cd core-plans

# build haproxy from its own directory
( cd haproxy && hab pkg build . )
```

### Build and install the test plans

Ensure that the terminal is located in the core-plans directory and a habitat studio is open.  Do the following steps:

```bash
# set environment from the last haproxy build
source haproxy/results/last_build.env

# install the haproxy artifact
hab pkg install haproxy/results/$pkg_artifact

# build the test plans
( cd haproxy/test/haproxy && build . )
( cd haproxy/test/webapp && build . )

# load the backend web application first
source haproxy/test/webapp/results/last_build.env
hab svc load $pkg_origin/$pkg_name

# load the haproxy load balancer
source haproxy/test/haproxy/results/last_build.env
hab svc load $pkg_origin/$pkg_name --bind=backend:webapp.default
```

Optionally perform the following manual test steps.  Both curl's should return content successfully

```bash
hab pkg install -b core/curl

# check that the backend webserver is running on port 9090
curl localhost:9090

# check that the haproxy on port 80 is reverse proxying to the backend webserver
curl localhost
```

Remain in the same habitat studio for the next section

### Run the tests

```bash
# install chef/inspec and dependency core/busybox
hab pkg install -b core/busybox
hab pkg install chef/inspec

# run the tests
hab pkg exec chef/inspec inspec exec ./haproxy/test
```

Sample output:

```bash
[7][default:/src:0]# hab pkg exec chef/inspec inspec exec ./haproxy/test

Profile: Habitat Core Plan haproxy (haproxy)
Version: 0.1.0
Target:  local://

  ✔  ensure haproxy binary command works: Bash command /hab/pkgs/core/haproxy/1.9.4/20190402100233/bin/haproxy --help
     ✔  Bash command /hab/pkgs/core/haproxy/1.9.4/20190402100233/bin/haproxy --help stdout should match /HA-Proxy version/
     ✔  Bash command /hab/pkgs/core/haproxy/1.9.4/20190402100233/bin/haproxy --help stderr should match /Usage : haproxy/
     ✔  Bash command /hab/pkgs/core/haproxy/1.9.4/20190402100233/bin/haproxy --help exit_status should eq 1
  ✔  ensure haproxy binary exists: File /hab/pkgs/core/haproxy/1.9.4/20190402100233/bin/haproxy
     ✔  File /hab/pkgs/core/haproxy/1.9.4/20190402100233/bin/haproxy should exist
  ✔  ensure haproxy process is running and owned by correct owner: Processes /haproxy/
     ✔  Processes /haproxy/ entries.length should eq 1
     ✔  Processes /haproxy/ users should include "root"
     ✔  HTTP GET on http://localhost status should cmp == 200
     ✔  HTTP GET on http://localhost body should match /Testing Haproxy Load Balancer/
  ✔  ensure haproxy service is listening: Port 80
     ✔  Port 80 should be listening
     ✔  Port 80 protocols should include "tcp"
     ✔  Port 80 processes should include "haproxy"


Profile Summary: 4 successful controls, 0 control failures, 0 controls skipped
Test Summary: 11 successful, 0 failures, 0 skipped
```

# Appendix

### Automate the build and test

Enter habitat studio  and choose one of the following options

1. To build haproxy and test

   ```bash
   ./haproxy/test/test.sh
   ```

2. To test an already built haproxy

   ```bash
   SKIPBUILD=1 ./haproxy/test/test.sh
   ```