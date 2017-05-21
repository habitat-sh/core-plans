Habitat plan for Prometheus's node exporter
======

Downloads a tarball for a released branch of node_exporter, compiles and runs it

Config
---
 
Minimal, as node_exporter joins a hab ring, the core/prometheus service will
automatically add each as a target for metric scraping.

Running
---

As noted by the node_exporter readme, this isn't normally run from
docker, so if you do, you'll want to run with some of the following options
for the full set of exported metrics:

```
docker run -d -p 9100:9100 \
  -v "/proc:/host/proc" \
  -v "/sys:/host/sys" \
  -v "/:/rootfs" \
  --net="host" \
  fastrobot/node_exporter \
  -collector.procfs /host/proc \
  -collector.sysfs /host/sys \
  -collector.filesystem.ignored-mount-points "^/(sys|proc|dev|host|etc)($|/)"
```

Here's an example of using the optional bindings from core/prometheus to 
dynamically populate prometheus's metric target list with any node_exporter
that appears in the ring

```
$ docker run -ti -P --rm --name node_exporter core/node_exporter --topology standalone --group demo
$ docker run -ti --rm -P --name prom0 core/prometheus --topology standalone --peer 172.17.0.3 --group demo --bind targets:node_exporter.demo
```

Room for Improvement
---

Currently the list of plugins run by node_exporter is static, normally they
are switched off and on at runtime. Those should probably be exposed as 
config via toml so that you could enable the plugins dynamically.
