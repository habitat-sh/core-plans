$pkg_name="windows-10-sdk"
$pkg_origin="core"
$pkg_version="10.0.22000"
$pkg_description="The Windows 10 SDK for Windows 10, version 2004 (servicing release 10.0.19041.685) provides the latest headers, libraries, metadata, and tools for building Windows 10 apps"
$pkg_upstream_url="https://developer.microsoft.com/en-us/windows/downloads/windows-10-sdk"
$pkg_license=@("Microsoft Software License")
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.microsoft.com/download/d/8/f/d8ff148b-450c-40b3-aeed-2a3944e66bbd/windowssdk/winsdksetup.exe"
$pkg_shasum="4d73ddc82caa1cbe82dffdc24b7cef368919e077bad984357d447568feab1f5f"
$pkg_build_deps=@("core/lessmsi")

$pkg_bin_dirs=@(
    "Windows Kits\10\bin\x64",
    "Windows Kits\10\bin\10.0.19041.0\x64"
)
$pkg_lib_dirs=@(
    "Windows Kits\10\Lib\10.0.19041.0\um\x64",
    "Windows Kits\10\Lib\10.0.19041.0\ucrt\x64"
)
$pkg_include_dirs=@(
    "Windows Kits\10\Include\10.0.19041.0\shared",
    "Windows Kits\10\Include\10.0.19041.0\ucrt",
    "Windows Kits\10\Include\10.0.19041.0\um",
    "Windows Kits\10\Include\10.0.19041.0\winrt"
)

function Invoke-SetupEnvironment {
    Set-RuntimeEnv -IsPath "WindowsSdkDir_10" "$pkg_prefix\Windows Kits\10"
}

function Invoke-Unpack {
    Start-Process "$HAB_CACHE_SRC_PATH/$pkg_filename" -Wait -ArgumentList "/features OptionId.DesktopCPPx64 /quiet /layout $HAB_CACHE_SRC_PATH/$pkg_dirname"
    Push-Location "$HAB_CACHE_SRC_PATH/$pkg_dirname"
    try {
        Get-ChildItem "$HAB_CACHE_SRC_PATH/$pkg_dirname/installers" -Include *.msi -Recurse | ForEach-Object {
            lessmsi x $_
        }
    } finally { Pop-Location }
    Get-ChildItem "$HAB_CACHE_SRC_PATH/$pkg_dirname" -Include @("x86", "arm", "arm64") -Recurse | ForEach-Object {
        Remove-Item $_ -Recurse -Force
    }
}

function Invoke-Install {
    Get-ChildItem "$HAB_CACHE_SRC_PATH/$pkg_dirname" -Include "Windows Kits" -Recurse | ForEach-Object {
        Copy-Item $_ "$pkg_prefix" -Exclude "*.duplicate*" -Recurse -Force
    }
}
