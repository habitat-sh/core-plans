$pkg_name="wix"
$pkg_origin="core"
$_base_version="3.11"
$pkg_version="${_base_version}.2"
$pkg_license=('MS-RL')
$pkg_upstream_url="http://wixtoolset.org/"
$pkg_description="The most powerful set of tools available to create your windows installation experience."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_filename=$pkg_name + ($_base_version).Replace(".", "") + "-binaries.zip"
$_release_name=$pkg_name + ($pkg_version).Replace(".", "") + "rtm"
$pkg_source="https://github.com/wixtoolset/wix3/releases/download/${_release_name}/${pkg_filename}"
$pkg_shasum="2c1888d5d1dba377fc7fa14444cf556963747ff9a0a289a3599cf09da03b9e2e"
$pkg_bin_dirs=@("bin")

function Invoke-Unpack {
    Expand-Archive -Path "$HAB_CACHE_SRC_PATH/${pkg_filename}" -DestinationPath "$HAB_CACHE_SRC_PATH/$pkg_dirname"
}

function Invoke-Install {
    Copy-Item * "$pkg_prefix/bin" -Recurse -Force
}
