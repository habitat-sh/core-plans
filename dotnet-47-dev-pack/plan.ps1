$pkg_name="dotnet-47-dev-pack"
$pkg_origin="core"
$pkg_version="4.7"
$pkg_description=".NET 4.7 Targeting Pack and the .NET 4.7 SDK."
$pkg_upstream_url="https://www.microsoft.com/net/download/all"
$pkg_license=@("Microsoft Software License")
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.visualstudio.microsoft.com/download/pr/fe069d49-7999-4ac8-bf8d-625282915070/d52a6891b5014014e1f12df252fab620/ndp47-devpack-kb3186612-enu.exe"
$pkg_shasum="efe311d8ea6a597860af8549b184d837da79b41f2c2c73d3ebe7386f2635544f"
$pkg_build_deps=@("core/lessmsi", "core/wix")

$pkg_bin_dirs=@("Program Files\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.7 Tools\x64")
$pkg_lib_dirs=@("Program Files\Windows Kits\NETFXSDK\4.7\Lib\um\x64")
$pkg_include_dirs=@("Program Files\Windows Kits\NETFXSDK\4.7\Include\um")

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
