pkg_name=caddy
pkg_origin=core
pkg_version=1.0.0
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=("Apache-2.0")
pkg_source="https://github.com/mholt/caddy/releases/download/v${pkg_version}/caddy_v${pkg_version}_linux_amd64.tar.gz"
pkg_shasum=e720c3a6593c878fc7ecc00baf4348683c0e8e35ab67d2db4d364881be96896e
pkg_description="Fast, cross-platform HTTP/2 web server with automatic HTTPS"
pkg_upstream_url=https://caddyserver.com
pkg_svc_run="caddy -conf ${pkg_svc_config_path}/Caddyfile"
pkg_exposes=(port)
pkg_exports=(
  [port]=http.port
)
pkg_bin_dirs=(bin)
pkg_deps=(core/glibc)
pkg_dirname="${pkg_name}-v${pkg_version}"

do_build() {
  return 0
}

do_install() {
  install -Dm755 "${HAB_CACHE_SRC_PATH}/caddy" "${pkg_prefix}/bin/caddy"
}
