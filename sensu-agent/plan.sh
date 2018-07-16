pkg_name=sensu-agent
pkg_filename=sensu-agent
pkg_origin=core
pkg_version="2.0.0-beta.2-4"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("MIT")
pkg_source="https://storage.googleapis.com/sensu-binaries/$pkg_version/linux/amd64/$pkg_filename"
pkg_svc_run="sensu-agent start -c $pkg_svc_config_path/agent.yml"
pkg_shasum="5825044fa69edc27fc74769001076c716a855a82103224727438f3ec0bbe8f90"
pkg_deps=(core/curl)
pkg_bin_dirs=(bin)
pkg_binds_optional=(
  [backend]="port"
)
pkg_description="Sensu 2.0 Agent"
pkg_upstream_url="https://sensu.io"

do_unpack(){
  return 0
}

do_build(){
  return 0
}

do_install() {
  build_line "Installing $pkg_filename binary"
  chmod +x "$HAB_CACHE_SRC_PATH/$pkg_filename"
  install -D "$HAB_CACHE_SRC_PATH/$pkg_filename" "$pkg_prefix/bin/$pkg_filename"
}
