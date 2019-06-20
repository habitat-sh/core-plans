$pkg_name="corretto8"
$pkg_origin="core"
$pkg_version="8.212.04.2"
$pkg_description="Corretto is a build of the Open Java Development Kit (OpenJDK) with long-term support from Amazon"
$pkg_upstream_url="https://aws.amazon.com/corretto/"
$pkg_license=@("GPL-2.0-only")
$pkg_license=@("GPLv2+CE")
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://d3pxv6yz143wms.cloudfront.net/${pkg_version}/amazon-corretto-${pkg_version}-windows-x64-jdk.zip"
$pkg_shasum="3c867c861f7aaf04f7d87dbc51e4075e0c45066e8a4b0ab2ac8cece8aa575c7e"
$pkg_dirname="amazon-corretto-$pkg_version"

function Invoke-SetupEnvironment {
    Set-RuntimeEnv JAVA_HOME "$pkg_prefix"
 }

function Invoke-Build {
    Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/*" "$pkg_prefix" -Recurse -Force
}
