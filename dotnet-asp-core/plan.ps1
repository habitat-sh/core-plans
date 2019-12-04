$pkg_name="dotnet-asp-core"
$pkg_origin="core"
$pkg_version="3.1.0"
$pkg_license=('MIT')
$pkg_upstream_url="https://docs.microsoft.com/en-us/aspnet/core"
$pkg_description="ASP.NET Core is a cross-platform, high-performance, open-source framework for building modern, cloud-based, Internet-connected applications."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.visualstudio.microsoft.com/download/pr/33fb1832-334a-4b72-ae47-ff9d07722cbd/f0b492014f4f5659a57c0f5f42913152/aspnetcore-runtime-$pkg_version-win-x64.zip"
$pkg_shasum="be7909a371e57df0d005223e2b4d91304e4a1d5ba0f1af5ac44b283e06974153"
$pkg_filename="asp-dotnet-win-x64.$pkg_version.zip"
$pkg_bin_dirs=@("bin")

function Invoke-Install {
  Copy-Item * "$pkg_prefix/bin" -Recurse -Force
}
