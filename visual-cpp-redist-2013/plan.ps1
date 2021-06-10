$pkg_name="visual-cpp-redist-2013"
$pkg_origin="core"
$pkg_version="12.0.30501"
$pkg_description="Run-time components that are required to run C++ applications that are built by using Visual Studio 2013."
$pkg_upstream_url="http://www.microsoft.com/en-us/download/details.aspx?id=40784"
$pkg_license=@("Microsoft Software License")
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="http://download.microsoft.com/download/2/E/6/2E61CFA4-993B-4DD4-91DA-3737CD5CD6E3/vcredist_x64.exe"
$pkg_shasum="e554425243e3e8ca1cd5fe550db41e6fa58a007c74fad400274b128452f38fb8"
$pkg_build_deps=@("core/lessmsi", "core/wix")
$pkg_bin_dirs=@("bin")

function Invoke-Unpack {
    dark -x "$HAB_CACHE_SRC_PATH/$pkg_dirname" "$HAB_CACHE_SRC_PATH/$pkg_filename"
    lessmsi x (Resolve-Path "$HAB_CACHE_SRC_PATH/$pkg_dirname/AttachedContainer\packages\vcRuntimeMinimum_amd64\vc_runtimeMinimum_x64.msi").Path

    if (!(Test-Path "$HAB_CACHE_SRC_PATH/$pkg_dirname/bin")) {
        Write-Output "Creating bin directory: $HAB_CACHE_SRC_PATH/$pkg_dirname/bin"
        New-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/bin" -ItemType Directory | Out-Null
    }
    Get-ChildItem "vc_runtimeMinimum_x64/SourceDir/system64" | ForEach-Object {
        Move-Item -Path $_.FullName -Destination "$HAB_CACHE_SRC_PATH/$pkg_dirname/bin/$($_.Name)"
    }

    Remove-Item vc_runtimeMinimum_x64 -Recurse -Force
}

function Invoke-Install {
    Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/bin/*.dll" "$pkg_prefix/bin" -Recurse
}
