$pkg_name = "ruby25"
$pkg_origin = "core"
$pkg_version = "2.5.8"
$pkg_revision = "2"
$pkg_description = "A repackaging of RubyInstaller2"
$pkg_maintainer = "The Chef Maintainers <maintainers@chef.io>"
$pkg_upstream_url = "https://rubyinstaller.org/"
$pkg_license = @("Apache-2.0")
$pkg_source = "https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-${pkg_version}-${pkg_revision}/rubyinstaller-${pkg_version}-${pkg_revision}-x64.exe"
$pkg_shasum = "2b1307ba0e4d6b330b210272f99a504e30f73ed331cca3a9e99e914b301f957a"
$pkg_bin_dirs = @(
  "bin"
)
$ruby_abi_version = [RegEx]::Replace($pkg_version, "\.\d+$", ".0")

function Invoke-SetupEnvironment {
  Push-RuntimeEnv -IsPath "GEM_PATH" "$pkg_prefix/lib/ruby/gems/$ruby_abi_version"
}

function Invoke-Unpack {
  Write-BuildLine "Unpacking $pkg_filename"
  Start-Process "$HAB_CACHE_SRC_PATH/$pkg_filename" -Wait -ArgumentList "/SP- /NORESTART /VERYSILENT /SUPPRESSMSGBOXES /NOPATH /DIR=$HAB_CACHE_SRC_PATH/$pkg_dirname"
}

function Invoke-Build {
  Write-BuildLine "Super Fast Build Process - It's Already Done!"
}

function Invoke-Install {
  Write-BuildLine "** Copying files to the package location"
  Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/*" "$pkg_prefix" -Recurse -Force
}

function Invoke-After {
  Write-BuildLine "** Clean-up unnecessary cached items"
  Get-ChildItem $pkg_prefix/lib/ruby/gems/$ruby_abi_version/gems -Filter "spec" -Recurse | Remove-Item -Recurse -Force
  Get-ChildItem $pkg_prefix/lib/ruby/gems/$ruby_abi_version/cache -Recurse | Remove-Item -Recurse -Force
  Get-ChildItem $pkg_prefix -Filter "unins000.*" | Remove-Item -Recurse -Force
  Get-ChildItem $pkg_prefix -Filter "share" | Remove-Item -Recurse -Force
}

function Invoke-End {
  Write-BuildLine "** Remove RubyInstaller installer from system state"
  Start-Process "$HAB_CACHE_SRC_PATH/$pkg_dirname/unins000.exe" -Wait -ArgumentList "/SILENT /NORESTART"
}