$pkg_name="chef-dk"
$pkg_origin="core"
$pkg_version="2.5.3"
$pkg_description="Chef developmet Kit."
$pkg_upstream_url="https://chef.io/"
$pkg_license=@("Apache-2.0")
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://packages.chef.io/files/stable/chefdk/${pkg_version}/windows/2016/chefdk-${pkg_version}-1-x64.msi"
$pkg_shasum="86d8b8408e317298e04a8a96ac45be7b4885973780280239d6abdc31081adf09"
$pkg_build_deps=@("core/lessmsi")
$pkg_bin_dirs=@(
    "chefdk/bin",
    "chefdk/embedded/bin"
)

function Invoke-Unpack {
  lessmsi x (Resolve-Path "$HAB_CACHE_SRC_PATH/$pkg_filename").Path
  Expand-Archive -Path "chefdk-${pkg_version}-1-x64/SourceDir/opscode/chefdk.zip" -DestinationPath "$HAB_CACHE_SRC_PATH/$pkg_dirname"
  Remove-Item chefdk-${pkg_version}-1-x64 -Recurse -Force
  Get-ChildItem "$HAB_CACHE_SRC_PATH/$pkg_dirname/embedded/bin/*.bat" | % {
    (Get-Content $_).Replace("C:\opscode\chefdk\embedded\bin", "%~dp0") | Set-Content $_
    (Get-Content $_).Replace("C:/opscode/chefdk/embedded/bin", "%~dp0") | Set-Content $_
  }
}

function Invoke-Install {
  Remove-Item "$pkg_prefix/chefdk/*" -Recurse
  Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/*" "$pkg_prefix/chefdk" -Recurse
}
