$pkg_name="node"
$pkg_origin="core"
$pkg_version="14.16.0"
$pkg_description="Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine."
$pkg_upstream_url="https://nodejs.org/"
$pkg_license=@("MIT")
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://nodejs.org/dist/v$pkg_version/node-v$pkg_version-x64.msi"
$pkg_shasum="d9243c9d02f5e4801b8b3ab848f45ce0da2882b5fff448191548ca49af434066"
$pkg_build_deps=@("core/lessmsi")
$pkg_bin_dirs=@("bin")

function Invoke-Unpack {
    mkdir "$HAB_CACHE_SRC_PATH/$pkg_dirname"

    Push-Location "$HAB_CACHE_SRC_PATH/$pkg_dirname"
    try {
        lessmsi x (Resolve-Path "$HAB_CACHE_SRC_PATH/$pkg_filename").Path
    } finally { Pop-Location }
}

function Invoke-Install {
    Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/node-v$pkg_version-x64/SourceDir/nodejs/*" "$pkg_prefix/bin" -Recurse
}

function Invoke-Check() {
    (& "$HAB_CACHE_SRC_PATH/$pkg_dirname/node-v$pkg_version-x64/SourceDir/nodejs/node" --version) -eq "v$pkg_version"
}
