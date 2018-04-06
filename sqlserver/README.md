# sqlserver

This packages Microsoft's Sql Server database. The plan downloads and packages the 2017 Express version which is a fully feature compatible SKU of full Sql Server that is free. There are some memory, scale, and size limitations that would prohibit one from wanting to run this version in production. However, one can override `{{cfg.custom_install_media_dir}}` and point it to their own Sql Server installer which could be any recent Sql Server version.

## Maintainers

The Habitat Maintainers humans@habitat.sh

## Type of Package

Service package that wraps the Microsoft Sql Server Engine Windows service

## Usage

### Building

This plan downloads the publicly available Sql Server Express 2017 installer. The initial installer is a very light waight installer that can be used to obtain the appropriate full install setup for Sql Server Express 2017.

This installer provides a choice of three Sql Server Express "flavors": Core Sql Engine, Advanced Sql Features, and a light weight user mode LocalDB. This plan downloads the Core Sql Engine since that provides an install and run environment similar to full Sql Server (unlike LocalDB) but does not add features like search and reporting that would bloat the built package with non key sql functionality.

One can of course modify the build if they would like to include advanced features or override `{{cfg.custom_install_media_dir}}` to point to an alternate location containing a Sql Server `setup.exe` installer.

### The SQL Server Install

The built package will include the full install media for Sql Server Express 2017 (~ 275MB). The first time the service is run, the `init` hook will run the SQL Server setup if it detects that the server has not been installed. All of the install options can be found in `config/config.ini`. All default data and log files will be created in the running service's data directory: `/hab/svc/sql-server-express-2017/data`.

The install will create a named instance defined in `{{cfg.instance}}`. So if a Sql Server engine of the same version in the installer (Express 2017 by default) is already installed on the machine, this will add the configured named instance.

### Initial User Setup and Configuration

The install creates an `sa` user with a password set from `{{cfg.sa_password}}`. Further, an application login and user is created after install with the values in `{{cfg.app_user}}` and `{{cfg.app_password}}`.

Note that you can supply a `user.toml` with an empty `app_user` and no app user will be added. Also, if the `app_password` is empty, the `post-run` hook assumes the `app_user` is a Windows login and will add the login as a Windows login.

### Running the Service

The Habitat `run` hook is mainly a wrapper around the named instance's sql engine Windows service. So the hook simply starts, watches, and stops that service.

Note that the installer installs the service with a `manual` startup type. So the database will not startup on server boot. It is intended that Habitat will control start and stop. You may run Habitat as a Windows service which is set to `automatic` by default and will therefore start on boot.

### Port Assignment and Firewall Configuration

The `init` hook edits the Sql Server Windows Registry location that controls which port the named instance listens to. Further `config/firewall.ps1` contains a DSC configuration that ensures that the firewall is open to listen on that port from all outside routes. The port is configured via `{{cfg.port}}`.

## Bindings

Consuming services can bind to sqlserver via:

```
hab svc start <origin>/<app> --bind database:sqlserver.default --peer <sql-host>
```

The package exposes the following attributes:

* `port` - The port Sql Server is listening on
* `instance` - The named instance of the Sql Server engine
* `username` - A username an application can use to connect to the database
* `password` - The password for the above username

An ASP.Net connection string, for example, may be configured like:

```
<add name="SchoolContext" connectionString="server={{bind.database.first.sys.ip}},{{bind.database.first.cfg.port}};uid={{bind.database.first.cfg.username}};pwd={{bind.database.first.cfg.password}};database=ContosoUniversity2;" providerName="System.Data.SqlClient" />
```

## Topologies

This plan will typically only be run in a `standalone` topology. If at least three nodes are running, there is nothing to prohibit running in a `leader` topology but there is no logic in this plan which takes specific advantage of that.

If you are running this plan with an Enterprise Sql Server SKU, use the `sqlserver-ha-ag` plan if you would like to cluster multiple Sql Server nodes using Sql Server AlwaysOn Availability Groups.

## Update Strategies

For more information on update strategies, see [this documentation](https://www.habitat.sh/docs/using-habitat/#update-strategy).

If you are running a standalone Sql Server instance and want to use an update strategy, you should use either "none" (which is the default update strategy) or "all-at-once".

If you are running a Sql Server cluster, you will likely want to use the Rolling strategy.

Note that this plan does not currently support updateing a Sql Server database engine in place. Update strategies for this plan are intended only to update hook scripts.

## Scaling

To cluster multiple Sql Server instances, use the `sqlserver-ha-ag` plan. That provides a service that should be started on the same node as all Sql Servers in your service group.

```
hab svc start core/sqlserver-ha-ag --bind database:sqlserver.default
```

See the `sqlserver-ha-ag` plan for more details.
