$pkg_name="visual-cpp-redist-2022"
$pkg_origin="core"
$pkg_version="14.40.33810"
$pkg_description="Run-time components that are required to run C++ applications that are built by using Visual Studio 2022."
$pkg_upstream_url="https://visualstudio.microsoft.com/downloads/#microsoft-visual-c-redistributable-for-visual-studio-2022"
$pkg_license=@("Microsoft Software License")
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.visualstudio.microsoft.com/download/pr/1754ea58-11a6-44ab-a262-696e194ce543/3642E3F95D50CC193E4B5A0B0FFBF7FE2C08801517758B4C8AEB7105A091208A/VC_redist.x64.exe"
$pkg_shasum="3642e3f95d50cc193e4b5a0b0ffbf7fe2c08801517758b4c8aeb7105a091208a"
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
