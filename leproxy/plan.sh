pkg_name=leproxy
pkg_origin=core
pkg_version="20180113"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("MIT")
pkg_source="https://github.com/artyom/${pkg_name}/releases/download/${pkg_version}/leproxy-linux-amd64.tar.gz"
pkg_shasum="c8a7ee698c8f4b4f828905d13978de30a79d6d394f992d8b1a170469c8e0d148"
pkg_bin_dirs=(bin)
pkg_description="https reverse proxy with automatic Letsencrypt usage for multiple hostnames/backends"
pkg_upstream_url="https://github.com/artyom/leproxy"

do_build() {
  mv "${HAB_CACHE_SRC_PATH}/leproxy" "${HAB_CACHE_SRC_PATH}/${pkg_dirname}/"
}

do_install() {
  install -Dm755 leproxy "${pkg_prefix}/bin/leproxy"
}
