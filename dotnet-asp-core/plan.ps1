$pkg_name="dotnet-asp-core"
$pkg_origin="core"
$pkg_version="2.1.5"
$pkg_license=('MIT')
$pkg_upstream_url="https://docs.microsoft.com/en-us/aspnet/core"
$pkg_description="ASP.NET Core is a cross-platform, high-performance, open-source framework for building modern, cloud-based, Internet-connected applications."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.visualstudio.microsoft.com/download/pr/6abfd5c4-f9e2-41fb-9363-fd60e3f9132f/1a5d3c82408f5e27b0e83be8c7f1ae42/aspnetcore-runtime-$pkg_version-win-x64.zip"
$pkg_shasum="5b15819d68fe5a3ea1b181e1e3c33cce9884b80182256492eb4c10836b7b9dce"
$pkg_filename="asp-dotnet-win-x64.$pkg_version.zip"
$pkg_bin_dirs=@("bin")

function Invoke-Install {
  Copy-Item * "$pkg_prefix/bin" -Recurse -Force
}
