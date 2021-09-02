$pkg_name="reportviewer2010"
$pkg_origin="core"
$pkg_version="10.0.30319.1"
$pkg_description="Microsoft Report Viewer 2010 Redistributable Package"
$pkg_license=@("Microsoft Software License")
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.microsoft.com/download/E/A/1/EA1BF9E8-D164-4354-8959-F96843DD8F46/ReportViewer.exe"
$pkg_shasum="7fd889bd694ef3e1c3580fb5c6cf741700fe3c70a01ecfd04c0edb566a381a9c"
$pkg_upstream_url="https://www.microsoft.com/en-us/download/details.aspx?id=6442"
$pkg_build_deps=@("core/lessmsi")
$pkg_bin_dirs=@("bin")

function Invoke-Unpack {
    Start-Process "$HAB_CACHE_SRC_PATH/$pkg_filename" -Wait -ArgumentList "/createlayout $HAB_CACHE_SRC_PATH/$pkg_dirname /q"
    Push-Location "$HAB_CACHE_SRC_PATH/$pkg_dirname"
    try {
        lessmsi x reportviewer_redist2010core.msi
    } finally { Pop-Location }
}

function Invoke-Install {
    Get-ChildItem "$HAB_CACHE_SRC_PATH/$pkg_dirname" -Include "Microsoft.ReportViewer.*.dll" -Recurse | ForEach-Object {
        Copy-Item $_ "$pkg_prefix/bin" -Recurse -Force
    }
}
