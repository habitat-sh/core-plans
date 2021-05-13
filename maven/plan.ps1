$pkg_name="maven"
$pkg_origin="core"
$pkg_version="3.8.1"
$pkg_description="Apache Maven is a software project management and comprehension tool"
$pkg_upstream_url="http://maven.apache.org/"
$pkg_license=@("Apache-2.0")
$pkg_deps=@("core/corretto8")
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://httpd-mirror.sergal.org/apache/${pkg_name}/maven-3/${pkg_version}/binaries/apache-maven-${pkg_version}-bin.zip"
$pkg_shasum="ba1517f73c5c22cf39afa0d570c998e6e024f37c75569f5c5524a69ff00a7f1b"
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
