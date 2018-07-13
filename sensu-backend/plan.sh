pkg_name=sensu-backend
pkg_filename=sensu-backend
pkg_origin=core
pkg_version="2.0.0-beta.2-4"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_source="https://storage.googleapis.com/sensu-binaries/$pkg_version/linux/amd64/$pkg_filename"
pkg_svc_run="sensu-backend start -c $pkg_svc_config_path/backend.yml"
pkg_shasum="c6aba03da9a60a3e2bfeaeeb9a5a4992d5d14407277681ac9f15543201b35a3a"
pkg_deps=(core/curl)
pkg_bin_dirs=(bin)
pkg_exports=(
  [port]=agent-port
)
pkg_description="Sensu 2.0 Backend"
pkg_upstream_url="https://sensu.io"

do_unpack(){
  return 0
}

do_build(){
  return 0
}

do_install() {
  build_line "Installing $pkg_filename binary"
  chmod +x $HAB_CACHE_SRC_PATH/$pkg_filename
  install -D $HAB_CACHE_SRC_PATH/$pkg_filename $pkg_prefix/bin/$pkg_filename
}
