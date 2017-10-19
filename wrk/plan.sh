pkg_name=wrk
pkg_origin=core
pkg_version=4.0.2
pkg_license=(Apache-2.0)
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Modern HTTP benchmarking tool"
pkg_upstream_url=https://github.com/wg/${pkg_name}
pkg_source=https://github.com/wg/${pkg_name}/archive/${pkg_version}.tar.gz
pkg_shasum=a4a6ad6727733023771163e7250189a9a23e6253b5e5025191baa6092d5a26fb
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
