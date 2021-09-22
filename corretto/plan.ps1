$pkg_name="corretto"
$pkg_origin="core"
$pkg_version="11.0.11.9.1"
$pkg_description="Corretto is a build of the Open Java Development Kit (OpenJDK) with long-term support from Amazon"
$pkg_upstream_url="https://aws.amazon.com/corretto/"
$pkg_license=@("GPL-2.0-only WITH Classpath-exception-2.0")
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://corretto.aws/downloads/resources/${pkg_version}/amazon-corretto-${pkg_version}-windows-x64-jdk.zip"
$pkg_shasum="2c51cddecaf5f6cf2e37ecbae168d4c759cf56cfbda80dab3f3c032ac5a38b1d"
$pkg_dirname="amazon-corretto-$pkg_version"
$pkg_bin_dirs=@("bin")
$pkg_lib_dirs=@("lib")

function Invoke-Build {
    Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/*" "$pkg_prefix" -Recurse -Force
}

function Invoke-Check {
    (& "$pkg_prefix/bin/java.exe" --version).StartsWith("openjdk version $pkg_version")
}
