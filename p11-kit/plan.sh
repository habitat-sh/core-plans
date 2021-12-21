pkg_name=p11-kit
pkg_origin=core
pkg_version=0.24.0
pkg_description="Provides a way to load and enumerate PKCS#11 modules."
pkg_upstream_url="https://p11-glue.github.io/p11-glue/p11-kit.html"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('BSD-3-Clause')
pkg_source="https://github.com/p11-glue/${pkg_name}/releases/download/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum=81e6140584f635e4e956a1b93a32239acf3811ff5b2d3a5c6094e94e99d2c685
pkg_deps=(
  core/libtasn1
  core/libffi
)
pkg_build_deps=(
  core/diffutils
  core/gcc
  core/make
  core/pkg-config
  core/gettext
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)

do_build() {
  ./configure --prefix="${pkg_prefix}" --without-trust-paths
  make
}

do_check() {
  # One test fails apparently because run as root
  make check
}
