$pkg_name="postgresql11-client"
$pkg_origin="core"
$pkg_version="11.1"
$pkg_license=('PostgreSQL')
$pkg_upstream_url="https://www.postgresql.org/"
$pkg_description="PostgreSQL is a powerful, open source object-relational database system."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://get.enterprisedb.com/postgresql/postgresql-${pkg_version}-1-windows-x64-binaries.zip"
$pkg_shasum="e158f4e7b714bde8fa5b37370f8646b31ea9ab87595320d900bea07add4a7887"

$pkg_deps=@(
    "core/visual-cpp-redist-2013"
)

$pkg_bin_dirs=@("bin")
$pkg_include_dirs=@("include")
$pkg_lib_dirs=@("lib")

$server_execs=@(
    "ecpg.exe"
    "initdb.exe"
    "pg_archivecleanup.exe"
    "pg_controldata.exe"
    "pg_resetxlog.exe"
    "pg_rewind.exe"
    "pg_test_fsync.exe"
    "pg_test_timing.exe"
    "pg_upgrade.exe"
    "pg_xlogdump.exe"
)

$server_includes=@(
    "informix"
    "server"
)

function Invoke-Install {
    Push-Location "pgsql"

    foreach ($dir in @("bin","include","lib"))
    {
        Copy-Item $dir "$pkg_prefix" -Recurse -Force
    }

    Write-Host "Purging unneeded execs"
    foreach ($unneeded in $server_execs)
    {
        $target = "$pkg_prefix\bin\$unneeded"
        Write-Host "Removing $target"
        Remove-Item -Path $target -Force
    }

    Write-Host "Purging Unneeded includes"
    foreach ($unneeded in $server_includes)
    {
        $target = "$pkg_prefix\include\$unneeded"
        Write-Host "Removing $target"
        Remove-Item -Path $target -Force -Recurse
    }

    Pop-Location
}
