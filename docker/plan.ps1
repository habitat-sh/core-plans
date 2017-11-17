$pkg_name = "docker"
$pkg_description = "The Docker Engine"
$pkg_origin = "core"
$pkg_version = "17.09.0"
$pkg_maintainer = "The Habitat Maintainers <humans@habitat.sh>"
$pkg_license = @("Apache-2.0")
$pkg_source = "https://download.docker.com/win/static/stable/x86_64/$pkg_name-$pkg_version-ce.zip"
$pkg_upstream_url = "https://docs.docker.com/engine/installation/binaries/"
$pkg_shasum = "aee9eed72facb59a6d06de047782ffef9011827be9f24b82dfff5b6792606c74"
$pkg_dirname = "docker"
$pkg_bin_dirs = @("bin")

function Invoke-Unpack {
    Expand-Archive -Path "$HAB_CACHE_SRC_PATH/$pkg_name-$pkg_version-ce.zip" -DestinationPath "$HAB_CACHE_SRC_PATH/$pkg_dirname"
}

function Invoke-Install {
    Copy-Item docker/* "$pkg_prefix/bin" -Recurse -Force
}
