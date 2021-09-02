$pkg_name="dotnet-asp-core"
$pkg_origin="core"
$pkg_version="3.1.14"
$pkg_license=('MIT')
$pkg_upstream_url="https://docs.microsoft.com/en-us/aspnet/core"
$pkg_description="ASP.NET Core is a cross-platform, high-performance, open-source framework for building modern, cloud-based, Internet-connected applications."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.visualstudio.microsoft.com/download/pr/33fb1832-334a-4b72-ae47-ff9d07722cbd/f0b492014f4f5659a57c0f5f42913152/aspnetcore-runtime-$pkg_version-win-x64.zip"
$pkg_shasum="e5d1e22325edd023d974d7e54c29295b1afedc9ac3dcc66825750ade32505a0f"
$pkg_filename="asp-dotnet-win-x64.$pkg_version.zip"
$pkg_bin_dirs=@("bin")

function Invoke-Install {
    Copy-Item * "$pkg_prefix/bin" -Recurse -Force
}
