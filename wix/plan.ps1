$pkg_name="wix"
$pkg_origin="core"
$pkg_version="3.10.3"
$pkg_license=('MS-RL')
$pkg_upstream_url="http://wixtoolset.org/"
$pkg_description="The most powerful set of tools available to create your windows installation experience."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://wix.codeplex.com/downloads/get/1587180"
$pkg_shasum="2c1888d5d1dba377fc7fa14444cf556963747ff9a0a289a3599cf09da03b9e2e"
$pkg_bin_dirs=@("bin")

function Invoke-Unpack {
    Move-Item "$HAB_CACHE_SRC_PATH/1587180" "$HAB_CACHE_SRC_PATH/wix310-binaries.zip"
    Expand-Archive -Path "$HAB_CACHE_SRC_PATH/wix310-binaries.zip" -DestinationPath "$HAB_CACHE_SRC_PATH/$pkg_dirname"
}

function Invoke-Install {
    Copy-Item * "$pkg_prefix/bin" -Recurse -Force
}
