$pkg_name="corretto"
$pkg_origin="core"
$pkg_version="11.0.3.7.1"
$pkg_description="Corretto is a build of the Open Java Development Kit (OpenJDK) with long-term support from Amazon"
$pkg_upstream_url="https://aws.amazon.com/corretto/"
$pkg_license=@("GPLv2+CE")
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://d3pxv6yz143wms.cloudfront.net/${pkg_version}/amazon-corretto-${pkg_version}-windows-x64.zip"
$pkg_shasum="bb90da7af62cf8380b533e5d74e8c3300d85657d2d450a461f9d754e9a34c5ba"
$pkg_dirname="amazon-corretto-$pkg_version"
$pkg_bin_dirs=@("bin")
$pkg_lib_dirs=@("lib")

function Invoke-Build {
    Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/*" "$pkg_prefix" -Recurse -Force
}

function Invoke-Check {
  (& "$HAB_CACHE_SRC_PATH/$pkg_dirname/bin/java.exe" --version).StartsWith("openjdk version $pkg_version")
}