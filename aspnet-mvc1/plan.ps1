$pkg_name="aspnet-mvc1"
$pkg_origin="core"
$base_version="1.0"
$pkg_version="$base_version.0"
$pkg_description="The ASP.NET MVC framework provides an alternative to the ASP.NET Web Forms pattern for creating MVC-based Web applications."
$pkg_upstream_url="https://www.asp.net/mvc/overview/older-versions-1"
$pkg_license=@("MS-PL")
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.microsoft.com/download/A/6/8/A68968AE-DE1D-4FA4-A98A-B74042C6090D/AspNetMVC1.msi"
$pkg_shasum="bbf8970a08a0bc825cf8521ce617dd6ad5eec04b5c9bf7d5e0fd1c06acf90a57"
$pkg_build_deps=@("core/lessmsi")

function Invoke-Unpack {
    lessmsi x (Resolve-Path "$HAB_CACHE_SRC_PATH/$pkg_filename").Path
    mkdir "$HAB_CACHE_SRC_PATH/$pkg_dirname"
    Copy-Item "AspNetMVC1/SourceDir/PFiles/Microsoft ASP.NET/ASP.NET MVC 1.0" "$HAB_CACHE_SRC_PATH/$pkg_dirname" -Recurse

    Remove-Item -Recurse -Force .\AspNetMVC1
}

function Invoke-Install {
    Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/ASP.NET MVC 1.0/*" "$pkg_prefix" -Recurse -Force
}
