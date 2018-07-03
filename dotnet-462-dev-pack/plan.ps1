$pkg_name="dotnet-462-dev-pack"
$pkg_origin="core"
$pkg_version="4.6.2"
$pkg_description=".net framework 4.6.2 with dev pack"
$pkg_upstream_url="https://www.microsoft.com/net/download/all"
$pkg_license=@("Microsoft Software License")
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.microsoft.com/download/E/F/D/EFD52638-B804-4865-BB57-47F4B9C80269/NDP462-DevPack-KB3151934-ENU.exe"
$pkg_shasum="e21d111fca26c1b39cc09a619127a962137c242ce086ad25b8b5e097a0c8e199"
$pkg_build_deps=@("core/lessmsi", "core/wix")
$pkg_bin_dirs=@("Program Files\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6.2 Tools\x64")
$pkg_lib_dirs=@("Program Files\Windows Kits\NETFXSDK\4.6.2\Lib\um\x64")
$pkg_include_dirs=@("Program Files\Windows Kits\NETFXSDK\4.6.2\Include\um")

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
