$pkg_name="dotnet-asp-core"
$pkg_origin="core"
$pkg_version="2.2.6"
$pkg_license=('MIT')
$pkg_upstream_url="https://docs.microsoft.com/en-us/aspnet/core"
$pkg_description="ASP.NET Core is a cross-platform, high-performance, open-source framework for building modern, cloud-based, Internet-connected applications."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.visualstudio.microsoft.com/download/pr/add4620e-7d1f-4e04-bff2-361fa1e19347/20e8bceb10fe70eb8a5255b1bed9d80d/aspnetcore-runtime-$pkg_version-win-x64.zip"
$pkg_shasum="a6e126db61d2f12c03de6d641dc684a23bab5f63cfaeb24b4a4df08fa6ceeb73"
$pkg_filename="asp-dotnet-win-x64.$pkg_version.zip"
$pkg_bin_dirs=@("bin")

function Invoke-Install {
  Copy-Item * "$pkg_prefix/bin" -Recurse -Force
}
