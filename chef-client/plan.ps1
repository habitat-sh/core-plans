$pkg_name="chef-client"
$pkg_origin="core"
$pkg_version="14.1.12"
$pkg_description="Chef Client"
$pkg_upstream_url="https://chef.io/"
$pkg_license=@("Apache-2.0")
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://packages.chef.io/files/stable/chef/${pkg_version}/windows/2016/chef-client-${pkg_version}-1-x64.msi"
$pkg_shasum="c546582d0cd9e23d06000bea566d380605e374e1facf4553791a5488ed2880e6"
$pkg_build_deps=@("core/lessmsi")
$pkg_bin_dirs=@(
    "chef/bin",
    "chef/embedded/bin"
)

function Invoke-Unpack {
  lessmsi x (Resolve-Path "$HAB_CACHE_SRC_PATH/$pkg_filename").Path
  Expand-Archive -Path "chef-client-${pkg_version}-1-x64/SourceDir/opscode/chef.zip" -DestinationPath "$HAB_CACHE_SRC_PATH/$pkg_dirname"
  Remove-Item chef-client-${pkg_version}-1-x64 -Recurse -Force
  Get-ChildItem "$HAB_CACHE_SRC_PATH/$pkg_dirname/embedded/bin/*.bat" | % {
    (Get-Content $_).Replace("C:\opscode\chef\embedded\bin", "%~dp0") | Set-Content $_
    (Get-Content $_).Replace("C:/opscode/chef/embedded/bin", "%~dp0") | Set-Content $_
  }
}

function Invoke-Install {
  Remove-Item "$pkg_prefix/chef/*" -Recurse
  Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/*" "$pkg_prefix/chef" -Recurse
}
