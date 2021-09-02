pkg_name=leproxy
pkg_origin=core
pkg_version="20191014"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("MIT")
pkg_source="https://github.com/artyom/${pkg_name}/releases/download/${pkg_version}/leproxy-linux-amd64.tar.gz"
pkg_shasum="21f04ed32f51b90854d899b653b52ee05cd1319310a9e8bc52c48e6e28859ef7"
pkg_bin_dirs=(bin)
pkg_description="https reverse proxy with automatic Letsencrypt usage for multiple hostnames/backends"
pkg_upstream_url="https://github.com/artyom/leproxy"

do_build() {
  mv "${HAB_CACHE_SRC_PATH}/leproxy" "${HAB_CACHE_SRC_PATH}/${pkg_dirname}/"
}

do_install() {
  install -Dm755 leproxy "${pkg_prefix}/bin/leproxy"
}
