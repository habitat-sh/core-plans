$pkg_name = "docker-credential-helper"
$pkg_description = "Docker Credential Helper"
$pkg_origin = "core"
$pkg_version = "0.6.4"
$pkg_maintainer = "The Habitat Maintainers <humans@habitat.sh>"
$pkg_license = @("MIT")
$pkg_source = "https://github.com/docker/docker-credential-helpers/releases/download/v$pkg_version/docker-credential-wincred-v$pkg_version-amd64.zip"
$pkg_upstream_url = "https://github.com/docker/docker-credential-helpers"
$pkg_shasum = "25031fec7fa0501666d47e63dc7593e2b0e6ad72c6bf13abef5917691ea47e37"
$pkg_bin_dirs = @("bin")

function Invoke-Unpack {
    Expand-Archive -Path "$HAB_CACHE_SRC_PATH/docker-credential-wincred-v$pkg_version-amd64.zip" -DestinationPath "$HAB_CACHE_SRC_PATH/$pkg_dirname"
}

function Invoke-Install {
    Copy-Item docker-credential-wincred.exe "$pkg_prefix/bin" -Force
}
