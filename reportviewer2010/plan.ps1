$pkg_name="reportviewer2010"
$pkg_origin="core"
$pkg_version="0.1.0"
$pkg_description="Microsoft Report Viewer 2010 Redistributable Package"
$pkg_license=@("Microsoft Software License")
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.microsoft.com/download/E/A/1/EA1BF9E8-D164-4354-8959-F96843DD8F46/ReportViewer.exe"
$pkg_shasum="e8ff182e202b321ac2b9245ee20c4eb659008ffb2a34cdbd3486f9da3d4c3e06"
$pkg_upstream_url="https://www.microsoft.com/en-us/download/details.aspx?id=6442"
$pkg_build_deps=@("core/lessmsi")
$pkg_bin_dirs=@("bin")

function Invoke-Unpack {
  Start-Process "$HAB_CACHE_SRC_PATH/$pkg_filename" -Wait -ArgumentList "/createlayout $HAB_CACHE_SRC_PATH/$pkg_dirname /q"
  Push-Location "$HAB_CACHE_SRC_PATH/$pkg_dirname"
  try {
      lessmsi x reportviewer_redist2010core.msi
  }
  finally { Pop-Location }
}

function Invoke-Install {
  Get-ChildItem "$HAB_CACHE_SRC_PATH/$pkg_dirname" -Include "Microsoft.ReportViewer.*.dll" -Recurse | % {
    Copy-Item $_ "$pkg_prefix/bin" -Recurse -Force
  }
}
