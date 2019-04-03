$pkg_name="dotnet-asp-core"
$pkg_origin="core"
$pkg_version="2.2.3"
$pkg_license=('MIT')
$pkg_upstream_url="https://docs.microsoft.com/en-us/aspnet/core"
$pkg_description="ASP.NET Core is a cross-platform, high-performance, open-source framework for building modern, cloud-based, Internet-connected applications."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.visualstudio.microsoft.com/download/pr/2cad0d7f-f980-4cd3-a86f-896adc881416/e37e4cf6615a9b78b36d62f952cca766/aspnetcore-runtime-$pkg_version-win-x64.zip"
$pkg_shasum="05dba4af81370a676ad8851cbd18fa2a2e275d98e22a7c597248a5038d24337e"
$pkg_filename="asp-dotnet-win-x64.$pkg_version.zip"
$pkg_bin_dirs=@("bin")

function Invoke-Install {
  Copy-Item * "$pkg_prefix/bin" -Recurse -Force
}
