$pkg_name="visual-cpp-redist-2015"
$pkg_origin="core"
$pkg_version="14.0.24215"
$pkg_description="Run-time components that are required to run C++ applications that are built by using Visual Studio 2015."
$pkg_upstream_url="https://www.microsoft.com/en-us/download/details.aspx?id=48145"
$pkg_license=@("Microsoft Software License")
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.microsoft.com/download/6/A/A/6AA4EDFF-645B-48C5-81CC-ED5963AEAD48/vc_redist.x64.exe"
$pkg_shasum="da66717784c192f1004e856bbcf7b3e13b7bf3ea45932c48e4c9b9a50ca80965"
$pkg_build_deps=@("core/lessmsi", "core/wix")
$pkg_bin_dirs=@("bin")

function Invoke-Unpack {
    dark -x "$HAB_CACHE_SRC_PATH/$pkg_dirname" "$HAB_CACHE_SRC_PATH/$pkg_filename"
    Push-Location "$HAB_CACHE_SRC_PATH/$pkg_dirname"
    try {
        lessmsi x (Resolve-Path "$HAB_CACHE_SRC_PATH/$pkg_dirname/AttachedContainer\packages\vcRuntimeMinimum_amd64\vc_runtimeMinimum_x64.msi").Path
    } finally { Pop-Location }
}

function Invoke-Install {
    Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/vc_runtimeMinimum_x64/SourceDir/system64/*.dll" "$pkg_prefix/bin" -Recurse
}
