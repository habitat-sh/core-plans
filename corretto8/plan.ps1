$pkg_name="corretto_jre8"
$pkg_origin="core"
$pkg_version="8.212.04.2"
$pkg_description="Corretto is a build of the Open Java Development Kit (OpenJDK) with long-term support from Amazon"
$pkg_upstream_url="https://aws.amazon.com/"
$pkg_license=@("GPL-2.0-only")
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://d3pxv6yz143wms.cloudfront.net/${pkg_version}/amazon-corretto-${pkg_version}-windows-x64-jre.zip"
$pkg_shasum="a69aafbdab5bb75740cf6e3b0638382a4c6ffb27b9d94e845fd143387bb0d6c3"
$pkg_dirname="amazon-corretto-$pkg_version"

function Invoke-SetupEnvironment {
  Set-RuntimeEnv JAVA_HOME "$pkg_prefix"
}

function Invoke-Build {
  Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/*" "$pkg_prefix" -Recurse -Force
}



