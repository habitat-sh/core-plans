$pkg_name="maven"
$pkg_origin="core"
$pkg_version="3.6.1"
$pkg_description="Apache Maven is a software project management and comprehension tool"
$pkg_upstream_url="http://maven.apache.org/"
$pkg_license=@("Apache-2.0")
$pkg_deps=@("core/corretto8")
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="http://mirrors.gigenet.com/apache/${pkg_name}/maven-3/${pkg_version}/binaries/apache-maven-${pkg_version}-bin.zip"
$pkg_shasum="7e6cfe98dc9c16ae6aa267db277860594695144d719c99d1fc519e89346a8edf"
$pkg_dirname="apache-$pkg_name-$pkg_version"

function Invoke-SetupEnvironment {
    Set-RuntimeEnv MAVEN_HOME "$pkg_prefix" [-force]
 }

function Invoke-Build {
    Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/*" "$pkg_prefix" -Recurse -Force
}
