$pkg_name="dotnet-asp-core"
$pkg_origin="core"
$pkg_version="2.1.6"
$pkg_license=('MIT')
$pkg_upstream_url="https://docs.microsoft.com/en-us/aspnet/core"
$pkg_description="ASP.NET Core is a cross-platform, high-performance, open-source framework for building modern, cloud-based, Internet-connected applications."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.visualstudio.microsoft.com/download/pr/aeab1a67-fec1-4525-af50-332817900212/016c23f84f53d0976da7070c88c7873f/aspnetcore-runtime-$pkg_version-win-x64.zip"
$pkg_shasum="8916d42fcc4abcadd13042f91fd1ebe2ca13a8fb1bb794802744b2aaaa94263c"
$pkg_filename="asp-dotnet-win-x64.$pkg_version.zip"
$pkg_bin_dirs=@("bin")

function Invoke-Install {
  Copy-Item * "$pkg_prefix/bin" -Recurse -Force
}
