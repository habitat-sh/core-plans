$pkg_name = "docker-credential-helper"
$pkg_description = "Docker Credential Helper"
$pkg_origin = "core"
$pkg_version = "0.6.3"
$pkg_maintainer = "The Habitat Maintainers <humans@habitat.sh>"
$pkg_license = @("MIT")
$pkg_source = "https://github.com/docker/docker-credential-helpers/releases/download/v$pkg_version/docker-credential-wincred-v$pkg_version-amd64.zip"
$pkg_upstream_url = "https://github.com/docker/docker-credential-helpers"
$pkg_shasum = "837fa8f21c0bc94a72938970913bfe3804090cade0e96d570f47002a6c2e21f1"
$pkg_bin_dirs = @("bin")

function Invoke-Unpack {
    Expand-Archive -Path "$HAB_CACHE_SRC_PATH/docker-credential-wincred-v$pkg_version-amd64.zip" -DestinationPath "$HAB_CACHE_SRC_PATH/$pkg_dirname"
}

function Invoke-Install {
    Copy-Item docker-credential-wincred.exe "$pkg_prefix/bin" -Force
}
