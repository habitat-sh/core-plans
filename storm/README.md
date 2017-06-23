Storm plan for Habitat
======================

Storm is divided in multiple components: nimbus, supervisor, ui.
Storm use Zookeeper has a store for a lot of informations. A Zookeeper cluster
is therefore needed for running Storm.
We will use Habitat bindings to link everything together.

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
HAB_STORM="run_as=nimbus" hab start core/storm --peer=<zookeeper_ip> \
	--bind=zookeeper:zookeeper.default  --bind=storm:storm-nimbus.default
```

### Supervisor

In charge to run the workers of the Storm cluster, you can build and deploy
this when Nimbus nodes have been started. In habitat you can do this by running
the following:

```bash
HAB_STORM="run_as=supervisor" hab start core/storm --peer=<zookeeper_ip> \
	--bind=zookeeper:zookeeper.default --bind=storm:storm-nimbus.default
```

### UI

Another service is the possibility to get an UI for Storm, a plan also exists
for this.

```bash
HAB_STORM="run_as=ui" hab start core/storm --peer=<zookeeper_ip> \
	--bind=zookeeper:zookeeper.default --bind=storm:storm-nimbus.default
```
