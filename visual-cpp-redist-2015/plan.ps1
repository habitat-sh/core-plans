$pkg_name="visual-cpp-redist-2015"
$pkg_origin="core"
$pkg_version="14.0.23026"
$pkg_description="Run-time components that are required to run C++ applications that are built by using Visual Studio 2015."
$pkg_upstream_url="https://www.microsoft.com/en-us/download/details.aspx?id=48145"
$pkg_license=@("Microsoft Software License")
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.microsoft.com/download/9/3/F/93FCF1E7-E6A4-478B-96E7-D4B285925B00/vc_redist.x64.exe"
$pkg_shasum="5eea714e1f22f1875c1cb7b1738b0c0b1f02aec5ecb95f0fdb1c5171c6cd93a3"
$pkg_build_deps=@("core/lessmsi", "core/wix")
$pkg_bin_dirs=@("bin")

function Invoke-Unpack {
  dark -x "$HAB_CACHE_SRC_PATH/$pkg_dirname" "$HAB_CACHE_SRC_PATH/$pkg_filename"
  Push-Location "$HAB_CACHE_SRC_PATH/$pkg_dirname"
  try {
    lessmsi x (Resolve-Path "$HAB_CACHE_SRC_PATH/$pkg_dirname/AttachedContainer\packages\vcRuntimeMinimum_amd64\vc_runtimeMinimum_x64.msi").Path
  }
  finally { Pop-Location }
}

function Invoke-Install {
  Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/vc_runtimeMinimum_x64/SourceDir/system64/*.dll" "$pkg_prefix/bin" -Recurse
}
