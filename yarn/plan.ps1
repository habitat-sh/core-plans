$pkg_name="yarn"
$pkg_origin="core"
$pkg_version="1.22.5"
$pkg_description="Yarn is a package manager for your code. It allows you to use and share code with other developers from around the world. Yarn does this quickly, securely, and reliably so you don't ever have to worry."
$pkg_maintainer="The Habitat Maintainers humans@habitat.sh"
$pkg_upstream_url="https://yarnpkg.com/"
$pkg_license=@("BSD-2-Clause")
$pkg_filename="$pkg_name-$pkg_version.msi"
$pkg_source="https://github.com/yarnpkg/yarn/releases/download/v${pkg_version}/${pkg_filename}"
$pkg_shasum="d7c895bc2a28df456d561ce78b8f9367b0b6a27fb5344d532868fe6f62245a60"
$pkg_bin_dirs=@("bin")
$pkg_deps=@("core/node")
$pkg_build_deps=@("core/lessmsi")

function Invoke-Unpack {
    Push-Location "$HAB_CACHE_SRC_PATH"
    try {
        lessmsi x (Resolve-Path "$HAB_CACHE_SRC_PATH/$pkg_filename").Path
    } finally {
        Pop-Location
    }
}
function Invoke-Build { }
function Invoke-Install {
    Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/SourceDir/Yarn/*" "$pkg_prefix" -Recurse -Force
}
