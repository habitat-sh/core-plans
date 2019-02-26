$pkg_name="dotnet-asp-core"
$pkg_origin="core"
$pkg_version="2.2.2"
$pkg_license=('MIT')
$pkg_upstream_url="https://docs.microsoft.com/en-us/aspnet/core"
$pkg_description="ASP.NET Core is a cross-platform, high-performance, open-source framework for building modern, cloud-based, Internet-connected applications."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.visualstudio.microsoft.com/download/pr/a61319fd-802b-4441-a4cc-84eb65468a04/2d2bb9011e1ee27af99deac554b0c055/aspnetcore-runtime-$pkg_version-win-x64.zip"
$pkg_shasum="4298a885940470ab1caf5c2a2ce025b66bd06b6273ad0bff5441720ab2242de6"
$pkg_filename="asp-dotnet-win-x64.$pkg_version.zip"
$pkg_bin_dirs=@("bin")

function Invoke-Install {
  Copy-Item * "$pkg_prefix/bin" -Recurse -Force
}
