# Habitat package: sql-server-express-2017

## Description

This packages Microsoft's Sql Server Express 2017 database. This is a fully feature compatible version of full Sql Server that is free. There are some memory, scale, and size limitations that would prohibit one from wanting to run this version in production.

This plan provides a solid means of packaging and deploying a development Sql Server environment and can be used as a template for deploying a full version of Sql Server.

## Building

This plan downloads the publicly available Sql Server Express 2017 installer. The initial installer is a very light waight installer that can be used to obtain the appropriate full install setup for Sql Server Express 2017.

This installer provides a choice of three Sql Server Express "flavors": Core Sql Engine, Advanced Sql Features, and a light weight user mode LocalDB. This plan downloads the Core Sql Engine since that provides an install and run environment similar to full Sql Server (unlike LocalDB) but does not add features like search and reporting that would bloat the built package with non key sql functionality.

One can of course modify the build if they would like to include advanced features.

## The SQL Server Install

The built package will include the full install media for Sql Server Express 2017 (~ 275MB). The first time the service is run, the `init` hook will run the SQL Server setup if it detects that the server has not been installed. All of the install options can be found in `config/config.ini`. All data and log files will be created in the running service's data directory: `/hab/svc/sql-server-express-2017/data`.

The install will create a named instance defined in `{{cfg.instance}}`. So if a Sql Server Express 2017 engine is already installed on the machine, this will add the configured named instance.

## Initial User Setup and Configuration

The install creates an `sa` user with a password set from `{{cfg.sa_password}}`. Further, an application login and user is created after install with the values in `{{cfg.app_user}}` and `{{cfg.app_password}}`.

## Running the Service

The Habitat `run` hook is mainly a wrapper around the named instance's sql engine Windows service. So the hook simply starts, watches, and stops that service.

Note that the installer installs the service with a `manual` startup type. So the database will not startup on server boot. It is intended that Habitat will control start and stop.

## Port Assignment and Firewall Configuration

The `init` hook edits the Sql Server Windows Registry location that controls which port the server listens to. Further `config/firewall.ps1` contains a DSC configuration that ensures that the firewall is open to liste on that port from all outside routes. The port is configured via `{{cfg.port}}`.

## Adapting this plan to package full Sql Server

The only part that should need to change to package a full Sql Server install is the `plan.ps1`. Instead of downloading the Sql Server Express installer, you would point to your own copy of the install media.

For example, if you had a Sql Server installation `iso` file mounted to `d:\`, your plan might look like this:

```
$pkg_name = "sqlserver"
$pkg_origin = "my_company"
$pkg_version = "0.1.0"
$pkg_maintainer = "Us folks"
$pkg_exports=@{
  port="port"
  password="app_password"
  username="app_user"
}
$pkg_description = "Microsoft SQL Server 2017"
$pkg_upstream_url = "https://www.microsoft.com/en-us/sql-server/sql-server-2017"
$pkg_bin_dirs = @("bin")
 
$setupDir = "d:"
 
function Invoke-Install {
  Copy-Item "$setupDir/*" $pkg_prefix/bin -Recurse
}
```
