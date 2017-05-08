Storm plan for Habitat
======================

This directory contains various plans to build a Storm cluster.
Storm is divided in multiple components: nimbus, supervisor, ui.
Storm use Zookeeper has a store for a lot of informations. A Zookeeper cluster
is therefore needed for running Storm.
We will use Habitat bindings to link everything together.

Building
--------

This plan is separated in 3 sub parts you will have to build. You can build
those services easily by running those commands:

```bash
cd core-plans/storm # move to storm plan directory

hab pkg build nimbus
hab pkg build supervisor
hab pkg build ui
```

Services
--------

### Zookeeper


Simply starts your zookeeper cluster with all the needed nodes:

```bash
hab start core/zookeeper
```

### Nimbus

Once Zookeeper is started we can start creating a Storm cluster by using what
Storm calls Nimbus nodes.

```bash
hab start core/storm-nimbus --peer=<zookeeper_ip> --bind=zookeeper:zookeeper.default \
	--bind=storm:storm-nimbus.default
```

### Supervisor

In charge to run the workers of the Storm cluster, you can build and deploy
this when Nimbus nodes have been started. In habitat you can do this by running
the following:

```bash
hab start core/storm-supervisor --peer=<zookeeper_ip> --bind=zookeeper:zookeeper.default \
	--bind=storm:storm-nimbus.default
```

### UI

Another service is the possibility to get an UI for Storm, a plan also exists
for this.

```bash
hab start core/storm-ui --peer=<zookeeper_ip> --bind=zookeeper:zookeeper.default \
	--bind=storm:storm-nimbus.default
```
