# Helix P4Broker

[**From Helix PerForce**](https://www.perforce.com/perforce/r17.1/manuals/p4dist/Content/P4Dist/)

The Helix Broker (P4Broker) enables you to implement local policies in your Perforce environment by allowing you to restrict the commands that can be executed, or redirect specific commands to alternate (replica or edge) Helix Core servers.

The Helix Broker is a server process that mediates between Perforce client applications and Helix Core servers, including proxy servers. For example, Perforce client applications can connect to a proxy server that connects to the broker, which then connects to a Helix Core server. Or, Perforce client applications can connect to a broker configured to redirect reporting-related commands to a read-only replica server, while passing other commands through to a master server. You can use a broker to solve load-balancing, security, or other issues that can be resolved by sorting requests directed to one or more Helix Core servers.

The work needed to install and configure a broker is minimal: the administrator needs to configure the broker and configure the users to access the Helix Core server through the broker. Broker configuration involves the use of a configuration file that contains rules for specifying which commands individual users can execute and how commands are to be redirected to the appropriate Perforce service. You do not need to backup the broker. In case of failure, you just need to restart it and make sure that its configuration file has not been corrupted.

From the perspective of the end user, the broker is transparent: users connect to a Helix Broker just as they would connect to any other Helix Versioning Engine.

Source: https://www.perforce.com/perforce/r17.1/manuals/p4dist/Content/P4Dist/chapter.broker.html

#### Habitat Version
The habitat version of this is an endeavor to allow effortless deployment of P4Broker daemons as needed, and support round-robin HA through multiple instances. Shared certificates and configurations are essential for HA.

## Maintainers

* [Daniel B. Hagen](https://github.com/dbhagen)

## Type of Package

Service

## Usage

First, load the service into your habitat environment:
```
hab svc load core/p4broker
```

If the service did not auto start (verify with the status command below), initiate service start:
```
hab svc start core/p4broker
```

To verify that the package service is running, execute the following:
```
hab svc status | grep p4broker
```

## Bindings

The service is currently untested in service binding. Eventual additional Helix packages could utilize this, but it is a TODO for now.

Address and port bindings are specified in the `default.toml` file, and a custom config file can be created and applied.

## Topologies

### Standalone

Currently, standalone is the only supported Topologies, but additional formats are being considered. To run in standalone topology, run the following command.
```
hab start core/p4broker
```
See Configuration Updates below to configure the service.

**TODO: Add Dockerized methodology.**

### Leader-Follower

**TODO: Implement topology.**

## Update Strategies

**TODO: Figure out update strategy.**

### Configuration Updates

For more information on update strategies, see [this documentation](https://www.habitat.sh/docs/using-habitat/#update-strategy)

The [`default.toml`](https://github.com/dbhagen/core-plans/blob/master/p4broker/default.toml) is located [here](https://github.com/dbhagen/core-plans/blob/master/p4broker/default.toml). Make a copy of it and configure it as suitable to your needs and then use the deploy commands mentioned in the document linked above. I would suggest a command like this:
```
hab config apply core/p4broker $(date +%s) myconfig.toml
```

The service will detect the new configuration and restart itself to incorporate them.

## Scaling

**TODO: Decide on scaling strategy.**

## Monitoring

To monitor the service, a simple TCP connection attempt will show if your ports are listening.

```
nc -vz <FQDNorIP> <Port>
```

With a `$P4PORT` environment variable properly configured for the P4Broker service location, you can issue a `p4 info` to verify the broker is alive and properly configured to target your PerForce instance.

```
export P4PORT=<SSL/TCP/UDP>:<FQDNorIP>:<PORT>
p4 info
```

## Notes

I am not the originator of P4Broker, or affiliated in any way. I find it is a great tool within the Helix ecosystem, and just want to wrap it in such a way to make it easier for myself and others to deploy in our environments. This has been my first Habitat package project, and it's been a blast to get involved. I'm totally open to collaboration, so please contact me if you would like to improve something!

My original code origin is here: https://github.com/dbhagen/core-plans/tree/master/p4broker
