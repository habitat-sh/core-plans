$pkg_name="dotnet-462-dev-pack"
$pkg_origin="core"
$pkg_version="4.6.2"
$pkg_description=".net framework 4.6.2 with dev pack"
$pkg_upstream_url="https://www.microsoft.com/net/download/all"
$pkg_license=@("Microsoft Software License")
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.visualstudio.microsoft.com/download/pr/ea744c52-1db4-4173-943d-a5d18e7e0d97/105c0e17be525bb0cebc7795d7aa1c32/ndp462-devpack-kb3151934-enu.exe"
$pkg_shasum="5d1399eabd7b11faaa8498c9c9112ecdc30de77b0f427c5ffbcc9a1a426a2f8f"
$pkg_build_deps=@("core/lessmsi", "core/wix")
$pkg_bin_dirs=@("Program Files\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6.2 Tools\x64")
$pkg_lib_dirs=@("Program Files\Windows Kits\NETFXSDK\4.6.2\Lib\um\x64")
$pkg_include_dirs=@("Program Files\Windows Kits\NETFXSDK\4.6.2\Include\um")

function Invoke-SetupEnvironment {
    Set-RuntimeEnv -IsPath "TargetFrameworkRootPath" "$pkg_prefix\Program Files\Reference Assemblies\Microsoft\Framework"
}

function Invoke-Unpack {
    dark -x "$HAB_CACHE_SRC_PATH/$pkg_dirname" "$HAB_CACHE_SRC_PATH/$pkg_filename"
    Push-Location "$HAB_CACHE_SRC_PATH/$pkg_dirname"
    try {
        Get-ChildItem "AttachedContainer/packages" -Include *.msi -Recurse | ForEach-Object {
            lessmsi x $_
        }
    } finally { Pop-Location }
}

function Invoke-Install {
    Get-ChildItem "$HAB_CACHE_SRC_PATH/$pkg_dirname" -Include "Program Files" -Recurse | ForEach-Object {
        Copy-Item $_ "$pkg_prefix" -Recurse -Force
    }
}
