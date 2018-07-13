. "..\postgresql-client\plan.ps1"

$pkg_name="postgresql94-client"
$pkg_origin="core"
$pkg_version="9.4.18"
$pkg_license=('PostgreSQL')
$pkg_upstream_url="https://www.postgresql.org/"
$pkg_description="PostgreSQL is a powerful, open source object-relational database system."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://get.enterprisedb.com/postgresql/postgresql-${pkg_version}-1-windows-x64-binaries.zip"
$pkg_shasum="88585ff89f785b0f473ec6788e944db61143ddb59c7fba6845351db60975e0bb"

$server_execs=@(
    "ecpg.exe"
    "initdb.exe"
    "pg_archivecleanup.exe"
    "pg_controldata.exe"
    "pg_resetxlog.exe"
    "pg_test_fsync.exe"
    "pg_test_timing.exe"
    "pg_upgrade.exe"
    "pg_xlogdump.exe"
)
