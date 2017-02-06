$pkg_name="visual-cpp-build-tools-2015"
$pkg_origin="core"
$pkg_version="14.0.25420"
$pkg_description="Standalone compiler, libraries and scripts"
$pkg_upstream_url="http://landinghub.visualstudio.com/visual-cpp-build-tools"
$pkg_license=@("Microsoft Software License")
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.microsoft.com/download/5/f/7/5f7acaeb-8363-451f-9425-68a90f98b238/visualcppbuildtools_full.exe"
$pkg_shasum="1e1774869abd953d05d10372b7c08bfa0c76116f5c6df1f3d031418ccdcd8f7b"
$pkg_build_deps=@("core/lessmsi")

$pkg_bin_dirs=@(
  "Program Files\Microsoft Visual Studio 14.0\VC\bin\amd64",
  "Program Files\Microsoft Visual Studio 14.0\VC\redist\x64\Microsoft.VC140.CRT"
)
$pkg_lib_dirs=@(
  "Windows Kits\10\Lib\10.0.10240.0\ucrt\x64",
  "Program Files\Microsoft Visual Studio 14.0\VC\lib\amd64",
  "Windows Kits\8.1\Lib\winv6.3\um\x64"
)
$pkg_include_dirs=@(
  "Windows Kits\10\Include\10.0.10240.0\ucrt",
  "Program Files\Microsoft Visual Studio 14.0\VC\include",
  "Windows Kits\8.1\Include\shared",
  "Windows Kits\8.1\Include\um"
)

function Invoke-Unpack {
  Start-Process "$HAB_CACHE_SRC_PATH/$pkg_filename" -Wait -ArgumentList "/passive /layout $HAB_CACHE_SRC_PATH/$pkg_dirname"
  Push-Location "$HAB_CACHE_SRC_PATH/$pkg_dirname"
  try {
    Get-ChildItem "$HAB_CACHE_SRC_PATH/$pkg_dirname/packages" -Include *.msi -Exclude @('*x86*', '*.arm.*') -Recurse | % {
      lessmsi x $_
    }
    Get-ChildItem "$HAB_CACHE_SRC_PATH/$pkg_dirname/packages/*SDK" -Include *.msi -Recurse | % {
      lessmsi x $_
    }

  }
  finally { Pop-Location }
}

function Invoke-Install {
  Get-ChildItem "$HAB_CACHE_SRC_PATH/$pkg_dirname" -Include "Program Files" -Recurse | % {
    Copy-Item $_ "$pkg_prefix" -Exclude "*.duplicate*" -Recurse -Force
  }
  Get-ChildItem "$HAB_CACHE_SRC_PATH/$pkg_dirname" -Include "Windows Kits" -Recurse | % {
    Copy-Item $_ "$pkg_prefix" -Exclude "*.duplicate*" -Recurse -Force
  }
}
