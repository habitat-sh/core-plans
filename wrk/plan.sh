pkg_name=wrk
pkg_origin=core
pkg_version=4.1.0
pkg_license=(Apache-2.0)
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Modern HTTP benchmarking tool"
pkg_upstream_url=https://github.com/wg/${pkg_name}
pkg_source=https://github.com/wg/${pkg_name}/archive/${pkg_version}.tar.gz
pkg_shasum=5c064c292b50f715206e1cd05cce97c2e605fd15348e70e43067bb2ac7c93f06
pkg_deps=(core/openssl core/gcc core/zlib)
pkg_build_deps=(core/make)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

do_build() {
  make WITH_OPENSSL="$(pkg_path_for core/openssl)"
}

do_install() {
  cp "${SRC_PATH}/${pkg_name}" "${pkg_prefix}/bin"
}
