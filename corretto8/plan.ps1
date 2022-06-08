$pkg_name="corretto8"
$pkg_origin="core"
$pkg_version="8.322.06.1"
$pkg_description="Corretto is a build of the Open Java Development Kit (OpenJDK) with long-term support from Amazon"
$pkg_upstream_url="https://aws.amazon.com/corretto/"
$pkg_license=@("GPLv2+CE")
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://corretto.aws/downloads/resources/${pkg_version}/amazon-corretto-${pkg_version}-windows-x64-jdk.zip"           
$pkg_shasum="0add49182709fdd37d51c90073ef6b071d485be977cf1418f89f50244d0d9246"
$pkg_dirname="amazon-corretto-$pkg_version"
$pkg_bin_dirs=@("bin")
$pkg_lib_dirs=@("lib")

function Invoke-Build {
    Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/*" "$pkg_prefix" -Recurse -Force
}

function Invoke-Check {
    try {
        (& "$HAB_CACHE_SRC_PATH/$pkg_dirname/jdk1.8.0_292/bin/java.exe" -version  2>&1)
        $false
    } catch {
        ($_ | Out-String).StartsWith("openjdk version `"1.8.0_292`"")
    }
}
