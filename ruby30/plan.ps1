$pkg_name = "ruby30"
$pkg_origin = "core"
$pkg_version = "3.0.2"
$pkg_revision = "1"
$pkg_description = "A repackaging of RubyInstaller2"
$pkg_maintainer = "The Chef Maintainers <maintainers@chef.io>"
$pkg_upstream_url = "https://rubyinstaller.org/"
$pkg_license = @("Apache-2.0")
$pkg_source = "https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-${pkg_version}-${pkg_revision}/rubyinstaller-${pkg_version}-${pkg_revision}-x64.exe"
$pkg_shasum = "eaaf4305187662a41d91506d3d1cee8ef72bd589687dd4431072c72c67635196"
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
