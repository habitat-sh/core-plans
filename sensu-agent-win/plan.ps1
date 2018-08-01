$pkg_name="sensu-agent-win"
$pkg_filename="sensu-agent"
$pkg_origin="core"
$pkg_version="2.0.0-beta.2-4"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=("MIT")
$pkg_source="https://storage.googleapis.com/sensu-binaries/$pkg_version/windows/amd64/$pkg_filename"
$pkg_svc_run="sensu-agent.exe start -c $pkg_svc_config_path/agent.yml"
$pkg_shasum="ebb8c9d26d5fdd293e247a720b7c0658f5274ab300b148c021468a594dc940e3"
$pkg_bin_dirs=@("bin")
$pkg_binds_optional=@{
  backend="port"
}
$pkg_description="Sensu 2.0 Agent"
$pkg_upstream_url="https://sensu.io"

function Invoke-Unpack {
  return 0
}

function Invoke-Build {
  return 0
}

function Invoke-Install {
  Write-BuildLine "Installing $pkg_filename binary"
  if(!(Test-Path "$pkg_prefix/bin")){
    mkdir "$pkg_prefix/bin"
  }
  Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_filename" "$pkg_prefix/bin/$pkg_filename.exe"
}
