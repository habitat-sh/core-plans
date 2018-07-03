# sqlserver2005

This packages Microsoft's Sql Server 2005 database with Service Pack 2. The plan downloads and packages the Express version which is a fully feature compatible SKU of full Sql Server that is free. There are some memory, scale, and size limitations that would prohibit one from wanting to run this version in production. However, one can override `{{cfg.custom_install_media_dir}}` and point it to their own Sql Server installer which could be any recent Sql Server version.

## Maintainers

The Habitat Maintainers humans@habitat.sh

## Type of Package

Service package that wraps the Microsoft Sql Server 2005 Engine Windows service

## Usage

### Building

This plan downloads the publicly available Sql Server Express 2005 with advanced services service pack 2 installer. The initial installer is a very light weight installer that can be used to obtain the appropriate full install setup for Sql Server Express 2005.

### The SQL Server Install

The built package will include the full install media for Sql Server Express 2005 (~ 250MB). The first time the service is run, the `init` hook will run the SQL Server setup if it detects that the server has not been installed. All of the install options can be found in `config/config.ini`. All default data and log files will be created in the running service's data directory: `/hab/svc/sqlserver2005/data`.

The install will create a named instance defined in `{{cfg.instance}}`. So if a Sql Server engine of the same version in the installer (Express 2005 by default) is already installed on the machine, this will add the configured named instance.

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
hab svc start <origin>/<app> --bind database:sqlserver2005.default --peer <sql-host>
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

## Sql Server 2005 and Containers

Yes, you can actually run SQL Server 2005 in a container! However there are a few "gotchas" and some unintuitive optimizations to be made to make this work well.

The primary problem encountered with Sql Server 2005 in a Container is that when it adds the `WindowsFeature` for .Net 3.5 in the `init` hook, it cannot fetch it from the public Windows Update servers. You have to explicitly point it to a `Source` that provides that feature.

### Finding the netfx3 (.net 3.5) source

If you have a Windows Server 2016 ISO file, this source will be located in the ISO's `sources\sxs` directory. If you do not have this ISO, you can get one for free at https://www.microsoft.com/en-us/evalcenter/evaluate-windows-server-2016/. The file you need is `microsoft-windows-netfx3-ondemand-package.cab`. Copy that file to a local directory:

```
mkdir c:\sxs
Copy-Item d:\sources\sxs\microsoft-windows-netfx3-ondemand-package.cab c:\sxs
```

Next you will need to make sure the local directory with the source is mounted to the container and that the `core/sqlserver2005` `netfx3_source` configuration setting points to the mounted directory.

### Mounting netfx3 in Containerized Studio

We need the studio to mount the above `c:\sxs` directory. You can specify this in the `HAB_DOCKER_OPTS` variable:

```
$env:HAB_DOCKER_OPTS='--memory 2gb --volume c:\sxs:c:/sxs'
hab studio enter
```

Now we need to pass the `netfx3_source` configuration to the supervisor.

```
'netfx3_source="c:/sxs"' | hab config apply sqlserver2005.default 1
hab svc load core/sqlserver2005
```

This will add the mounted source to the `DSC` `WindowsFeature` resource so that it can install the .net 3.5 runtime in the `init` hook.

### Mounting netfx3 to an exported Docker image

If you have exported the `core/sqlserver2005` package to a docker image, you will need to make sure it gets the right mount and Supervisor configuration in order to install .Net 3.5. Use the following example in your `docker run` command:

```
docker run --memory 2gb -e "HAB_SQLSERVER2005=netfx3_source='c:/sxs'" --volume c:/sxs:c:/sxs -it core/sqlserver2005
```

### Running an exported Sql Server container "quickly"

The `core/sqlserver2005` `init` hook takes several minutes to run the first time. Given the immutable nature of a container, running an exported image will perform a clean `init` run on every `docker run` making for a very suboptimal experience. To create a `sqlserver2005` image that already has .Net 3.5 and Aql Server 2005 installed and ready to run, perform the following:

```
# Start a fresh container that will perform the install
docker run --memory 2gb -e "HAB_SQLSERVER2005=netfx3_source='c:/sxs'" --volume c:/sxs:c:/sxs -it core/sqlserver2005
# Stop (ctrl-C) the container after it completes the `post-run` hook.
# Commit this container to a new image
docker commit <CONTAINER_ID> sqlserver2005
# Now running sqlserver2005 will have everything already installed
docker run -it --memory 2GB sqlserver2005
```

## Topologies

This plan will typically only be run in a `standalone` topology.

## Update Strategies

For more information on update strategies, see [this documentation](https://www.habitat.sh/docs/using-habitat/#update-strategy).

If you are running a standalone Sql Server instance and want to use an update strategy, you should use either "none" (which is the default update strategy) or "all-at-once".

If you are running a Sql Server cluster, you will likely want to use the Rolling strategy.

Note that this plan does not currently support updateing a Sql Server database engine in place. Update strategies for this plan are intended only to update hook scripts.
