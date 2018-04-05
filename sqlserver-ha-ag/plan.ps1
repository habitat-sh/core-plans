$pkg_name="sqlserver-ha-ag"
$pkg_origin="core"
$pkg_version="0.1.0"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=@("SQL Server 2017 License")

$pkg_deps=@("core/dsc-core")
$pkg_exports=@{
  name="availability_group_name"
  ip="availability_group_ip"
}
$pkg_binds=@{
  "database"="instance port"
}

$pkg_description = "Microsoft SQL Server Always On Availability Group"
$pkg_upstream_url="https://docs.microsoft.com/en-us/sql/database-engine/availability-groups/windows/always-on-availability-groups-sql-server"
