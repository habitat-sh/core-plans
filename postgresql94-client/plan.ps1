. "..\postgresql-client\plan.ps1"

$pkg_name="postgresql94-client"
$pkg_origin="core"
$pkg_version="9.4.26"
$pkg_license=('PostgreSQL')
$pkg_upstream_url="https://www.postgresql.org/"
$pkg_description="PostgreSQL is a powerful, open source object-relational database system."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://get.enterprisedb.com/postgresql/postgresql-${pkg_version}-1-windows-x64-binaries.zip"
$pkg_shasum="da57e66c0ca11bfa091d20190eab54922b4718e3031035e7e4db0ff74d4ec2d7"

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
