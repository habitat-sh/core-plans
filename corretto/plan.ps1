$pkg_name="corretto"
$pkg_origin="core"
$pkg_version="11.0.14.10.1"
$pkg_description="Corretto is a build of the Open Java Development Kit (OpenJDK) with long-term support from Amazon"
$pkg_upstream_url="https://aws.amazon.com/corretto/"
$pkg_license=@("GPL-2.0-only WITH Classpath-exception-2.0")
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://corretto.aws/downloads/resources/${pkg_version}/amazon-corretto-${pkg_version}-windows-x64-jdk.zip"
$pkg_shasum="f97c5d750322d9dc30428f1c3174abf94bf7f1c921305187759568a313ee950f"
$pkg_dirname="amazon-corretto-$pkg_version"
$pkg_bin_dirs=@("bin")
$pkg_lib_dirs=@("lib")

function Invoke-Build {
    Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/*" "$pkg_prefix" -Recurse -Force
}

function Invoke-Check {
    (& "$pkg_prefix/bin/java.exe" --version).StartsWith("openjdk version $pkg_version")
}
