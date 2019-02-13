$pkg_name="dotnet-45-dev-pack"
$pkg_origin="core"
$pkg_version="0.1.0"
$pkg_description=".net framework 4.5 with dev pack"
$pkg_upstream_url="https://www.microsoft.com/net/download/all"
$pkg_license=@("Microsoft Software License")
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="http://download.microsoft.com/download/F/1/3/F1300C9C-A120-4341-90DF-8A52509B23AC/standalonesdk/sdksetup.exe"
$pkg_shasum="412b16fe0268b3271902bb450ca412e4f074278c30dcaec7ab762662ace80262"
$pkg_build_deps=@("core/lessmsi")
$pkg_bin_dirs=@("Program Files\Microsoft SDKs\Windows\v8.0A\bin\NETFX 4.0 Tools\x64")
$pkg_lib_dirs=@("Program Files\Windows Kits\8.0\Lib\Win8\um\x64")
$pkg_include_dirs=@("Program Files\Windows Kits\8.0\Include\um")

function Invoke-Unpack {
  Start-Process "$HAB_CACHE_SRC_PATH/$pkg_filename" -Wait -ArgumentList "/features OptionId.NetFxSoftwareDevelopmentKit /layout $HAB_CACHE_SRC_PATH/$pkg_dirname /quiet"
  Push-Location "$HAB_CACHE_SRC_PATH/$pkg_dirname/Redistributable/4.5.50710"
  try {
    Get-ChildItem "*.msi" | % {
        lessmsi x $_
    }
  }
  finally { Pop-Location }
}

function Invoke-Install {
  Get-ChildItem "$HAB_CACHE_SRC_PATH/$pkg_dirname" -Include "Program Files" -Recurse | % {
    Copy-Item $_ "$pkg_prefix" -Recurse -Force
  }
  Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/Redistributable/4.5.50710/netfx45_dtp/SourceDir/ProgramFilesFolder/*" "$pkg_prefix/Program Files" -Recurse
}
