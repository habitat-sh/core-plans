$pkg_name="inspec"
$pkg_origin="core"
$pkg_version="2.1.84"
$pkg_description="Inspec"
$pkg_upstream_url="https://chef.io/"
$pkg_license=@("Apache-2.0")
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://packages.chef.io/files/stable/inspec/${pkg_version}/windows/2016/inspec-${pkg_version}-1-x64.msi"
$pkg_shasum="6069ef101ca825409a5956862bbba62c411146c880f4e308b1aa888fa1225da4"
$pkg_build_deps=@("core/lessmsi")
$pkg_bin_dirs=@(
    "inspec/bin",
    "inspec/embedded/bin"
)

function Invoke-Unpack {
  lessmsi x (Resolve-Path "$HAB_CACHE_SRC_PATH/$pkg_filename").Path
  Expand-Archive -Path "inspec-${pkg_version}-1-x64/SourceDir/opscode/inspec.zip" -DestinationPath "$HAB_CACHE_SRC_PATH/$pkg_dirname"
  Remove-Item inspec-${pkg_version}-1-x64 -Recurse -Force
  Get-ChildItem "$HAB_CACHE_SRC_PATH/$pkg_dirname/embedded/bin/*.bat" | % {
    (Get-Content $_).Replace("C:\opscode\inspec\embedded\bin", "%~dp0") | Set-Content $_
    (Get-Content $_).Replace("C:/opscode/inspec/embedded/bin", "%~dp0") | Set-Content $_
  }
}

function Invoke-Install {
  Remove-Item "$pkg_prefix/inspec/*" -Recurse
  Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/*" "$pkg_prefix/inspec" -Recurse
}