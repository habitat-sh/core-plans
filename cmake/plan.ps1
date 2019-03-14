$pkg_name="cmake"
$pkg_origin="core"
$base_version="3.13"
$pkg_version="$base_version.2"
$pkg_description="CMake is an open-source, cross-platform family of tools designed to build, test and package software"
$pkg_upstream_url="https://cmake.org/"
$pkg_license=@("BSD-3-Clause")
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="http://cmake.org/files/v$base_version/cmake-$pkg_version-win64-x64.msi"
$pkg_shasum="c680993e59e0547d0161e43587530acdb2e5c3f5dd8a1a17be18b60e1617b5be"
$pkg_build_deps=@("core/lessmsi")
$pkg_bin_dirs=@("bin")

function Invoke-Unpack {
  lessmsi x (Resolve-Path "$HAB_CACHE_SRC_PATH/$pkg_filename").Path
  mkdir "$HAB_CACHE_SRC_PATH/$pkg_dirname"
  Move-Item "cmake-$pkg_version-win64-x64/SourceDir/cmake" "$HAB_CACHE_SRC_PATH/$pkg_dirname"
}

function Invoke-Install {
  Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/cmake/*" "$pkg_prefix" -Recurse -Force
}
