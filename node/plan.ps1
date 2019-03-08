$pkg_name="node"
$pkg_origin="core"
$pkg_version="11.11.0"
$pkg_description="Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine."
$pkg_upstream_url="https://nodejs.org/"
$pkg_license=@("MIT")
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://nodejs.org/dist/v$pkg_version/node-v$pkg_version-x64.msi"
$pkg_shasum="215473345ea3893790b01588170e795070ab769533556f2c7baa3fa9bfac4b4e"
$pkg_build_deps=@("core/lessmsi")
$pkg_bin_dirs=@("bin")

function Invoke-Unpack {
  mkdir "$HAB_CACHE_SRC_PATH/$pkg_dirname"

  Push-Location "$HAB_CACHE_SRC_PATH/$pkg_dirname"
  try {
    lessmsi x (Resolve-Path "$HAB_CACHE_SRC_PATH/$pkg_filename").Path
  }
  finally { Pop-Location }
}

function Invoke-Install {
  Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/node-v$pkg_version-x64/SourceDir/nodejs/*" "$pkg_prefix/bin" -Recurse
}

function Invoke-Check() {
  (& "$HAB_CACHE_SRC_PATH/$pkg_dirname/nodejs/node" --version) -eq "v$pkg_version"
}
