$pkg_name="dotnet-asp-core"
$pkg_origin="core"
$pkg_version="3.1.23"
$pkg_license=('MIT')
$pkg_upstream_url="https://docs.microsoft.com/en-us/aspnet/core"
$pkg_description="ASP.NET Core is a cross-platform, high-performance, open-source framework for building modern, cloud-based, Internet-connected applications."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.visualstudio.microsoft.com/download/pr/60c1fe64-3c9d-4a13-bffa-65aff86d039c/28bd30b0f5adaf8c99c5df019cfe826e/aspnetcore-runtime-$pkg_version-win-x64.zip"
$pkg_shasum="01033f57c3a278ac69d12b5f5bcad72d0516f8b97ca73dd415987be2ba56d026"
$pkg_filename="asp-dotnet-win-x64.$pkg_version.zip"
$pkg_bin_dirs=@("bin")

function Invoke-Install {
    Copy-Item * "$pkg_prefix/bin" -Recurse -Force
}
