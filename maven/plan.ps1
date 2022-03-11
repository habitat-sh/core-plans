$pkg_name="maven"
$pkg_origin="core"
$pkg_version="3.8.4"
$pkg_description="Apache Maven is a software project management and comprehension tool"
$pkg_upstream_url="http://maven.apache.org/"
$pkg_license=@("Apache-2.0")
$pkg_deps=@("core/corretto8")
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="http://mirrors.gigenet.com/apache/${pkg_name}/maven-3/${pkg_version}/binaries/apache-maven-${pkg_version}-bin.zip"
$pkg_shasum="ccd67d1ee4fd79339c9b6f95d1e5e1e0e0209a8c1b095d9291e009afa0a492a5"
$pkg_dirname="apache-$pkg_name-$pkg_version"
$pkg_bin_dirs=@("bin")
$pkg_lib_dirs=@("lib")

function Invoke-Prepare {
    $env:JAVA_HOME = "$(Get-HabPackagePath corretto8)"
    Write-BuildLine "Setting JAVA_HOME=$env:JAVA_HOME"
}
function Invoke-Build {
    Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/*" "$pkg_prefix" -Recurse -Force
}
function Invoke-Check{
    (& "$HAB_CACHE_SRC_PATH/$pkg_dirname/bin/mvn.cmd" -v).StartsWith("Apache Maven $pkg_version")
}
