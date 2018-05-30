$pkg_name="dotnet-47-dev-pack"
$pkg_origin="core"
$pkg_version="4.7"
$pkg_description=".NET 4.7 Targeting Pack and the .NET 4.7 SDK."
$pkg_upstream_url="https://www.microsoft.com/net/download/all"
$pkg_license=@("Microsoft Software License")
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.microsoft.com/download/A/1/D/A1D07600-6915-4CB8-A931-9A980EF47BB7/NDP47-DevPack-KB3186612-ENU.exe"
$pkg_shasum="16346bd9c464ae6439bd702702d5377beb1b623683a4415db5dbd3160318f625"
$pkg_build_deps=@("core/lessmsi", "core/wix")

$pkg_bin_dirs=@("Program Files\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.7 Tools\x64")
$pkg_lib_dirs=@("Program Files\Windows Kits\NETFXSDK\4.7\Lib\um\x64")
$pkg_include_dirs=@("Program Files\Windows Kits\NETFXSDK\4.7\Include\um")

function Invoke-Unpack {
  dark -x "$HAB_CACHE_SRC_PATH/$pkg_dirname" "$HAB_CACHE_SRC_PATH/$pkg_filename"
  Push-Location "$HAB_CACHE_SRC_PATH/$pkg_dirname"
  try {
    Get-ChildItem "AttachedContainer/packages" -Include *.msi -Recurse | % {
        lessmsi x $_
    }
  }
  finally { Pop-Location }
}

function Invoke-Install {
  Get-ChildItem "$HAB_CACHE_SRC_PATH/$pkg_dirname" -Include "Program Files" -Recurse | % {
    Copy-Item $_ "$pkg_prefix" -Recurse -Force
  }
}
