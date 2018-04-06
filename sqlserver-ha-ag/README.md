# sqlserver-ha-ag

Enables and configures a Sql Server Always On Availability Group including the Windows Failover Clustering setup.

## Maintainers

The Habitat Maintainers humans@habitat.sh

## Type of Package

Service

## Usage

### Requirements:

* You must be running the `core/sqlserver` Habitat service which must be running an Enterprise version of Sql Server in order to access the `AlwaysOn` feature.
* Your SqlServer nodes should be joined to an Active Directory domain
* The supervisor running this service must be running under a Domain Administrator account and should also have a `sysadmin` Sql Server login.

### Configuration

Here are all  toml properties supported:

* `endpoint_port` - The mirroring endpoint port created on the Sql Server instances. `5022` is the default. This plan will ensure the firewall has enabled inbound traffic on this port.
* `probe_port` - The probe port of the Availability Group Listener (defaults to 59999).
* `availability_group_name` - The Availability Group name (defaults to `AG`). This will also be the DNS name of the listener.
* `availability_group_ip` - The IP Address of the Availability Group Listener. There is no default and no listener will be created if ommited.
* `availability_group_failover_threshold` - Number of failovers permitted every 6 hours (1 is the default).
* `backup_path` - The path where backups of the primary node are sent and used to restore the secondary nodes prior to replication. This directory must exist and be readable and writable by the account running the supervisors that run this service. The default is `"\\$env:computername\backup"`.
* `databases` - The database(s) to be joined to the Availability Group. If there are more than one, this should be a comma delimited list. If none are included, no data will be synchronized (default is `"''"`).
* `cluster_name` - The name used for the Windows Failover Cluster (defaults to `sql`).
* `cluster_ip` - The static IP address of the Windows Failover Cluster. This MUST be overridden and is empty by default.
* `failover_mode` - The `FailoverMode` of the availability group (defaults to `Automatic`).
* `availability_mode` - The `AvailabilityMode` of the availability goup (defaults to `SynchronousCommit`).

### Running the service

Running the sqlserver-ha-ag service will Configure Windows Failover Clustering and a Sql Server Always On Availability Group. You should start the service after all `sqlserver` nodes are running and the database you want to join has been created.

The service should bind to `sqlserver` and run on each supervisor where `sqlserver` runs in the same service group.

```
hab svc start core/sqlserver-ha-ag --bind database:sqlserver.default
```

## Bindings

Consuming services can bind to sqlserver-ha-ag via:

```
hab svc start <origin>/<app> --bind database:sqlserver.default cluster:sqlserver-ha-ag.default --peer <sql-host>
```

Note they should bind to both this service and the `sqlserver` service.

The package exposes the following attributes:

* `name` - The DNS name of the Availability Group Listener.
* `ip` - The IP address of the Availability Group Listener.

An ASP.Net connection string, for example, may be configured like:

```
  {{#if bind.cluster}}
    <add name="SchoolContext" connectionString="Data Source={{bind.cluster.first.cfg.name}},{{bind.database.first.cfg.port}};Initial Catalog=ContosoUniversity2;Integrated Security=SSPI;" providerName="System.Data.SqlClient" />
  {{else}}
    <add name="SchoolContext" connectionString="Data Source={{bind.database.first.sys.ip}},{{bind.database.first.cfg.port}};Initial Catalog=ContosoUniversity2;Integrated Security=SSPI;" providerName="System.Data.SqlClient" />
  {{/if}}
```

## Topologies

This plan will typically only be run in a `standalone` topology. If at least three nodes are running, there is nothing to prohibit running in a `leader` topology but there is no logic in this plan which takes specific advantage of that.

## Update Strategies

For more information on update strategies, see [this documentation](https://www.habitat.sh/docs/using-habitat/#update-strategy).

If you are running a standalone instance and want to use an update strategy, you should use either "none" (which is the default update strategy) or "all-at-once". You must have at least three instances to use a "rolling" strategy.

## Scaling

This service does not currently do a good job of dynimically adding extra nodes. You can add additional Sql Server nodes and this plan should add them to the cluster but currently you must ensure that the added node has a restored database in order for synchronization to occur.
